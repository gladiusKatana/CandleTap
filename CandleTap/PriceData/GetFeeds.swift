/*🔥CandleTap_GetFeeds💧*/import UIKit

extension ApiService {
    
    func getKrakenFeed(_ completion: @escaping ([KrakenApiResponse]) -> ()) {
        fetchKrakenFeedForUrlString(urlString: "\(baseUrl)\(krakenPair)&interval=240&since=0", completion: completion)
    }
    
    func getShakepayFeed(_ completion: @escaping ([ShakepayApiResponse]) -> ()) {
        fetchShakepayFeedForUrlString(urlString: "https://api.shakepay.co/rates", completion: completion)
    }
    
}

