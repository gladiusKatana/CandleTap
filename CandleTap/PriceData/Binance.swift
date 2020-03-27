/*🔥CandleTap_Binance💧*/import UIKit

func fetchBinanceDirectFeedForUrlString(urlString: String) {            //print("fetching binance")
    
    guard let url = URL(string: urlString) else {print("error binding binance url"); return}
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else { print("error binding krk  data  parameter in URLSession"); return}
        
        do {
            guard let binanceCandles
                = try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyObject]] else {
                    print("error converting bnc json to array of arrays"); return
            }
            
            globalBinanceCandles = binanceCandles
            
        } catch let error {                                             // as Error { //or as NSError
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    .resume()
}

//func fetchBinanceFeedForUrlString(urlString: String, completion: @escaping ([BinanceApiResponse]) -> ()) {
//
//    guard let url = URL(string: urlString) else {print("error binding binance url"); return}
//
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//        guard let data = data else { print("error binding krk  data  parameter in URLSession"); return}
//
//        do {
//            guard let jsonDictionaries
//                = try [JSONSerialization.jsonObject(with: data, options: .mutableContainers)] as? [[String: AnyObject]] else {
//                    print("error converting krk json to array of dictionaries"); return
//            }
//
//            completion(jsonDictionaries.map({return BinanceApiResponse(dictionary: $0)}))
//
//        } catch let error {
//            print("Error serializing json:", error.localizedDescription)
//        }
//    }
//    .resume()
//}
//
//class BinanceApiResponse: SafeJsonObject {
//        init(dictionary: [String: AnyObject]) {
//        super.init()
//        setValuesForKeys(dictionary)
//    }
//}

