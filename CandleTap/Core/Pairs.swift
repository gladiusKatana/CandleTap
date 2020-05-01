/*🔥CandleTap_Pairs💧*/import Foundation

var tickerPairs = ["BTCCAD",
                   "XBTCAD",
                   "ETHBTC",
                   "XRPBTC",
                   "BCHBTC",
                   "LTCBTC",
                   "BSVBTC",
                   "EOSBTC"]/*,
                   "BNBBTC",
                   "XMRBTC",
                   "TRXBTC",
                   "ADABTC",
                   "XLMBTC",
                   "XTZBTC"]*/

var currentPrices = [latestShakepayBTCCAD, latestKrakenXBTZCAD, latestBinanceETHBTC]

var binanceETHBTCHistorical = [[[AnyObject]]]()

var binanceETHBTCHistoricalForPrinting = [[[AnyObject]]]()


enum Timescale : String {

    case minute = ""; case fiveMinute, fifteenMinute, thirtyMinute, hour, fourHour, twelveHour, day, threeDay, week, month

    func urlSymbol() -> String {
        switch self {
        case .minute:           return "1m"
        case .fiveMinute:       return "5m"
        case .fifteenMinute:    return "15m"
        case .thirtyMinute:     return "30m"
        case .hour:             return "1h"
        case .fourHour:         return "4h"
        case .twelveHour:       return "12h"
        case .day:              return "1d"
        case .threeDay:         return "3d"
        case .week:             return "1w"
        case .month:            return "1M"
            
        }
    }
    
    func description() -> String {
        switch self {
        case .minute:           return "1 minute"
        case .fiveMinute:       return "5 minutes"
        case .fifteenMinute:    return "15 minutes"
        case .thirtyMinute:     return "30 minutes"
        case .hour:             return "1 hour"
        case .fourHour:         return "4 hours"
        case .twelveHour:       return "12 hours"
        case .day:              return "1 day"
        case .threeDay:         return "3 days"
        case .week:             return "1 week"
        case .month:            return "1 month"
            
        }
    }
}

