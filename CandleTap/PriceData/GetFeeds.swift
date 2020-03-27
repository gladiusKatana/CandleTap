/*🔥CandleTap_GetFeeds💧*/import UIKit

extension ApiService {
    
    func getShakepayFeed(_ completion: @escaping ([ShakepayApiResponse]) -> ()) {
        fetchShakepayFeedForUrlString(urlString: "https://api.shakepay.co/rates", completion: completion)
    }
    
    func getKrakenFeed(_ completion: @escaping ([KrakenApiResponse]) -> ()) {
        fetchKrakenFeedForUrlString(urlString: "\(baseKrakenUrl)\(krakenPair)&interval=30", completion: completion)
    }
    
//    func getBinanceFeed(urlString: String,
//                        _ completion: @escaping () -> ()) {
//        fetchBinanceFeedForUrlString(urlString: urlString, completion: completion)
//    }
    
}

