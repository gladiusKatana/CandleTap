/*🔥CandleTap_GetFeeds💧*/import UIKit

extension ApiService {
    
    func getShakepayFeed(_ completion: @escaping ([ShakepayApiResponse]) -> ()) {
        fetchShakepayLatestOHLCs(urlString: "https://api.shakepay.co/rates", completion: completion)
    }
    
    func getKrakenFeed(_ completion: @escaping ([KrakenApiResponse]) -> ()) {
        fetchKrakenLatestOHLCs(urlString: "\(baseKrakenUrl)\(krakenPair)&interval=15", completion: completion)
    }
    
    //    func getBinanceFeed(urlString: String,
    //                        _ completion: @escaping () -> ()) {
    //        fetchBinanceFeedForUrlString(urlString: urlString, completion: completion)
    //    }
    
}

enum ExchangeID: Int {
    case binance = 0; case kraken, shakepay
}

