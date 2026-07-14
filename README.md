# XAUUSD M1 Sniper EA v1.0

**Advanced Bank Manipulation + SMC + Liquidity Trading Robot for MetaTrader 5**

---

## Strategy Overview

This Expert Advisor (EA) is designed for **XAUUSD** on **M1 timeframe**.

### Settings:
- **Lot Size**: 0.03
- **Stop Loss**: 15 pips
- **Take Profit**: 22 pips
- **Max Daily Loss**: $15
- **Magic Number**: 12345

---

## Installation

### Step 1: Download ZIP
1. Click **"Code"** (green button)
2. Click **"Download ZIP"**
3. Extract to Downloads

### Step 2: Copy to MetaTrader 5
1. Open MetaTrader 5
2. **File** → **Open Data Folder**
3. **MQL5** → **Experts**
4. Copy `Expert.mq5` here

### Step 3: Open in MetaEditor
1. **Tools** → **MetaEditor** (Ctrl+Shift+E)
2. **File** → **Open** → Select `Expert.mq5`
3. Press **F7** to compile
4. Wait for "Compilation done"

### Step 4: Deploy on Chart
1. Open **XAUUSD** chart
2. Set timeframe to **M1**
3. **Navigator** → **Expert Advisors** → **Expert**
4. Drag **Expert** onto chart
5. Enable "Allow live trading"
6. Click **OK**

---

## Trading Signals

### Buy Signal:
- Price breaks below previous low, then closes above it
- Volume spike (>120% of previous)

### Sell Signal:
- Price breaks above previous high, then closes below it
- Volume spike (>120% of previous)

---

## Risk Management

- **Daily loss limit**: $15
- **Risk per trade**: ~$4.50
- **Reward per trade**: ~$6.60
- **Reward-to-Risk**: 1.47:1

---

## Troubleshooting

### Compilation Error
- Check that `Expert.mq5` is in Experts folder
- Press F7 again

### EA Not Trading
- Verify symbol is **XAUUSD**
- Verify timeframe is **M1**
- Check account balance (min $100)
- Check spread (should be <5 pips)

### EA Stops After Daily Loss
- This is normal! Daily loss limit is $15
- EA resumes trading next day at 00:00 UTC

---

## Version
- v1.0 (2024)

## License
For educational and trading purposes only. Use at your own risk.

**Happy Trading!**