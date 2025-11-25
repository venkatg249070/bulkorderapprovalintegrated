const express = require("express");
const xsenv = require("@sap/xsenv");
const hdbext = require("@sap/hdbext");
 
// ------------------------------------------------------------
// Load environment (HANA + optionally XSUAA)
// ------------------------------------------------------------
try {
  xsenv.loadEnv();
} catch (err) {
  console.error("ENV load error:", err.message);
}
 
// Load services
const services = xsenv.getServices({
  hana: { name: "WKKC_DEP-db" },
});
 
// HANA is required
const hana_service = services.hana;
 
// XSUAA is optional (not needed for batch jobs)
let xsuaa_service = null;
try {
  xsuaa_service = xsenv.getServices({ xsuaa: { tag: "xsuaa" } }).xsuaa;
  if (xsuaa_service) {
    console.log("⚠️ XSUAA detected, authentication skipped for batch jobs.");
  }
} catch (err) {
  console.log("🔓 No XSUAA found -> running WITHOUT authentication (local run).");
}
 
// ------------------------------------------------------------
// Initialize Express
// ------------------------------------------------------------
const app = express();
 
// ------------------------------------------------------------
// HANA middleware
// ------------------------------------------------------------
app.use(hdbext.middleware(hana_service));
 
// ------------------------------------------------------------
// Stored procedures
// ------------------------------------------------------------
const jobProcedures = {
  WKKC_STR: `CALL "77ECCC4540AC4C10BD36B319B3956023"."RT_WKKC_STR_IN.START_REPLICATION"()`
};
 
// ------------------------------------------------------------
// Job Scheduler endpoint
// ------------------------------------------------------------
app.get("/api/start-job", async (req, res) => {
  const jobId = req.query.jobId;
 
  if (!jobId) {
    return res.status(400).send({ error: "Missing jobId" });
  }
 
  const sql = jobProcedures[jobId];
  if (!sql) {
    return res.status(404).send({ error: `Unknown jobId: ${jobId}` });
  }
 
  console.log(`🚀 Job Triggered: ${jobId}`);
 
  try {
    const client = req.db;
 
    const result = await new Promise((resolve, reject) => {
      client.exec(sql, (err, rows) => {
        if (err) reject(err);
        else resolve(rows);
      });
    });
 
    console.log(`✅ Job ${jobId} executed successfully.`);
    res.send({ status: "success", jobId, result });
  } catch (err) {
    console.error("❌ ERROR:", err);
    res.status(500).send({ status: "error", message: err.message });
  }
});
 
// ------------------------------------------------------------
// Health Check
// ------------------------------------------------------------
app.get("/", (req, res) => {
  res.send("BatchJobs Server is running.");
});
 
// ------------------------------------------------------------
// Start Server
// ------------------------------------------------------------
const port = process.env.PORT || 3010;
app.listen(port, () => {
  console.log(`🚀 Server running on port ${port}`);
});
