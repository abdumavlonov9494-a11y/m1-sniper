#property strict
#property copyright "M1 Sniper EA"
#property version "1.0"
#property description "XAUUSD M1 Sniper - Bank Manipulation + SMC + Liquidity"

const double LOT_SIZE = 0.03;
const int SL_PIPS = 15;
const int TP_PIPS = 22;
const int MAGIC_NUMBER = 12345;
const double MAX_DAILY_LOSS = 15.0;

int OnInit()
{
    if(Symbol() != "XAUUSD")
    {
        Alert("This EA works only on XAUUSD!");
        return INIT_FAILED;
    }
    
    if(Period() != PERIOD_M1)
    {
        Alert("This EA works only on M1 timeframe!");
        return INIT_FAILED;
    }
    
    Print("=== XAUUSD M1 Sniper EA Initialized ===");
    Print("SL: ", SL_PIPS, " pips | TP: ", TP_PIPS, " pips");
    Print("Lot Size: ", LOT_SIZE);
    Print("Max Risk: ", MAX_DAILY_LOSS, "$");
    
    return INIT_SUCCEEDED;
}

void OnTick()
{
    if(CountOpenPositions() > 0)
        return;
    
    if(GetDailyLoss() >= MAX_DAILY_LOSS)
        return;
    
    if(CheckBuySignal())
        OpenBuyTrade();
    
    if(CheckSellSignal())
        OpenSellTrade();
}

bool CheckBuySignal()
{
    double low0 = Low[0];
    double low1 = Low[1];
    double close0 = Close[0];
    long vol0 = Volume[0];
    long vol1 = Volume[1];
    
    bool liquidityTest = (low0 < low1) && (close0 > low1);
    bool volumeConfirm = vol0 > (vol1 * 1.2);
    
    int signalCount = 0;
    if(liquidityTest) signalCount++;
    if(volumeConfirm) signalCount++;
    
    return (signalCount >= 1);
}

bool CheckSellSignal()
{
    double high0 = High[0];
    double high1 = High[1];
    double close0 = Close[0];
    long vol0 = Volume[0];
    long vol1 = Volume[1];
    
    bool liquidityTest = (high0 > high1) && (close0 < high1);
    bool volumeConfirm = vol0 > (vol1 * 1.2);
    
    int signalCount = 0;
    if(liquidityTest) signalCount++;
    if(volumeConfirm) signalCount++;
    
    return (signalCount >= 1);
}

void OpenBuyTrade()
{
    double entry = Ask;
    double sl = entry - (SL_PIPS * Point);
    double tp = entry + (TP_PIPS * Point);
    
    int ticket = OrderSend(Symbol(), OP_BUY, LOT_SIZE, entry, 10, sl, tp, 
                           "M1 Sniper Buy", MAGIC_NUMBER, 0, clrGreen);
    
    if(ticket > 0)
    {
        Print("BUY Order opened. Ticket: ", ticket);
        Print("Entry: ", entry, " | SL: ", sl, " | TP: ", tp);
    }
    else
    {
        Print("Error opening BUY order. Error: ", GetLastError());
    }
}

void OpenSellTrade()
{
    double entry = Bid;
    double sl = entry + (SL_PIPS * Point);
    double tp = entry - (TP_PIPS * Point);
    
    int ticket = OrderSend(Symbol(), OP_SELL, LOT_SIZE, entry, 10, sl, tp, 
                           "M1 Sniper Sell", MAGIC_NUMBER, 0, clrRed);
    
    if(ticket > 0)
    {
        Print("SELL Order opened. Ticket: ", ticket);
        Print("Entry: ", entry, " | SL: ", sl, " | TP: ", tp);
    }
    else
    {
        Print("Error opening SELL order. Error: ", GetLastError());
    }
}

int CountOpenPositions()
{
    int count = 0;
    for(int i = OrdersTotal() - 1; i >= 0; i--)
    {
        if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC_NUMBER)
                count++;
        }
    }
    return count;
}

double GetDailyLoss()
{
    double loss = 0;
    datetime today = TimeCurrent() - (TimeCurrent() % 86400);
    
    for(int i = OrdersHistoryTotal() - 1; i >= 0; i--)
    {
        if(OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
        {
            if(OrderSymbol() == Symbol() && OrderMagicNumber() == MAGIC_NUMBER)
            {
                if(OrderCloseTime() >= today)
                {
                    double profit = OrderProfit();
                    if(profit < 0)
                        loss += MathAbs(profit);
                }
            }
        }
    }
    return loss;
}

void OnDeinit(const int reason)
{
    Print("=== XAUUSD M1 Sniper EA Deinitialized ===");
}