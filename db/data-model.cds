namespace strbw;

entity Orders {
    @title: 'Order Number'
    key orderNumber           : String;
    @title: 'Item Number'
    key itemNumber                : String;
    @title: 'Product'
    product                   : String;
    @title: 'Source Location'
    sourceLocation            : String;
    @title: 'Destination Location'
    destinationLocation       : String;
    @title: 'Mode of Transport'
    mot                       : String;
    @title: 'Quantity'
    quantity                  : Decimal(17,3);
    @title: 'Unit of Measure'
    uom                       : String;
    @title: 'Category'
    category                  : String;
    @title: 'Category Description'
    categoryDescription       : String;
    @title: 'Start Date'
    startDate                 : String;
    @title: 'End Date'
    endDate                   : String;
    @title: 'Destination Day Supply'
    destDaySupp               : Decimal(18,3);
    @title: 'Destination Stock On Hand'
    destStockOH               : Decimal(18,3);
    @title: 'MOT2'
    mot2                      : String;
    @title: 'ABC Class'
    abcClass                  : String;
    @title: 'Week'
    week                      : String;
    @title: 'Approve Load'
    approveLoad               : Boolean;
    @title: 'Reason Code'
    reasonCode                : String;
//new fields    
    @title: 'Fastest MOT'
    fastestMOT               : String;
    @title: 'Slowest MOT'
    slowestMOT                : String;
    @title: 'Product Category'
    productCategory          : String;
    @title : 'Estimated Risk'
    estimatedRisk            : Decimal(15,2);
    @title : 'Profit At Risk'
    profitAtRisk            : Decimal(17,3);
    @title : 'Cost Delta'
    costDelta                : Decimal(17,3);
    @title : 'Impact Amount'
    impactAmount            : Decimal(17,3);
    @title: 'Fasted MOT Cost'
    fastestMOTCost           : Decimal(17,3);
    @title : 'Slowest MOT Cost'
    slowestMOTCost          : Decimal(17,3);
    @title: 'Fastest MOT Duration Days'
    fastestMOTDurationDays       : String;
    @title: 'Slowest MOT Duration Days'
    slowestMOTDurationDays      : String;
    @title : 'AI Reason'
    aiReason                    : String;
    @title: 'AI Output'
    aiOutput                    : String;
} 

entity reasonCodeVH  {
    key reasonCode: String;
    description: String;
}

entity mot2VH  {
    key MOT2: String;
}

entity STR_INLLM {
    key ORDER_NUMBER              : String(12);
        ITEM_NUMBER               : String(6);
        PRODUCT_NUMBER            : String(18);
        CATEGORY                  : String(3);
        CATEGORY_DESC             : String(50);
        SOURCE                    : String(4);
        DESTINATION               : String(4);
        MOT                       : String(8);
        START_DATE                : String(8);
        END_DATE                  : String(8);
        FASTEST_MOT               : String(8);
        SLOWEST_MOT               : String(8);
        PRODUCT_CATEGORY          : String(10);

        STR_QTY                   : Decimal(17,3);
        ESTIMATED_RISK            : Decimal(15,2);
        PROFIT_AT_RISK            : Decimal(17,3);
        COST_DELTA                : Decimal(17,3);
        IMPACT_AMOUNT             : Decimal(17,3);
        FASTEST_MOT_COST          : Decimal(17,3);
        SLOWEST_MOT_COST          : Decimal(17,3);
        FASTEST_MOT_DURATION_DAYS : Double;
        SLOWEST_MOT_DURATION_DAYS : Double;
        DEST_DAYS_OF_SUPPLY       : Decimal(18,3);
        DEST_STOCK_ON_HAND        : Decimal(18,3);
}
