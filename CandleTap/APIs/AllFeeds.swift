/*🔥CandleTap_GetFeeds💧*/import UIKit

extension ApiService {
    
    func getShakepayFeed(_ completion: @escaping ([ShakepayApiResponse]) -> ()) {
        fetchShakepayLatestOHLCs(urlString: "https://api.shakepay.co/rates", completion: completion)
    }
    
    func getKrakenFeed(_ completion: @escaping ([KrakenApiResponse]) -> ()) {
        fetchKrakenLatestOHLCs(urlString: "\(baseKrakenUrl)\(krakenPair)&interval=15", completion: completion)
    }
    
    func getBinanceFeed(_ completion: @escaping ([BinanceLatestPrice]) -> ()) {
        fetchBinanceLatestPrice(urlString: "https://api.binance.com/api/v1/ticker/price?symbol=ETHBTC", completion: completion)
    }
    
    
    func getKrakenHistoricalFeed(ticker: String, interval: Timescale, startTime: Int64,
                                 completion: @escaping ([KrakenApiResponse]) -> ()) {
        fetchKrakenHistoricalOHLCs(ticker: ticker, interval: interval, startTime: startTime, completion: completion)
    }
    
}

enum ExchangeID: Int {
    case binance = 0; case kraken, shakepay
}

