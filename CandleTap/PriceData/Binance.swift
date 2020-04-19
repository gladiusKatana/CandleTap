/*🔥CandleTap_Binance💧*/import UIKit

func fetchBinanceLatestPrice(urlString: String, completion: @escaping ([BinanceLatestPrice]) -> ()) {
    
    guard let url = URL(string: urlString) else {
        //print("error binding shk url")
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            //print("error binding shk  data  parameter in URLSession")
            return
        }
        
        do {
            guard let jsonDictionaries
                = try [JSONSerialization.jsonObject(with: data, options: .mutableContainers)] as? [[String: AnyObject]] else {
                    print("error converting shk json to array of dictionaries")
                    return
            }
            
            completion(jsonDictionaries.map({return BinanceLatestPrice(dictionary: $0)}))
            
        } catch let error {
            print("Error serializing json:", error.localizedDescription)
        }
    }
    .resume()
}

class BinanceLatestPrice: SafeJsonObject {
    @objc var symbol: AnyObject?
    @objc var price: AnyObject?
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

/*
 //func fetchBinanceLatestOHLCs(urlString: String) {                                                //print("fetching binance")
 //
 //    guard let url = URL(string: urlString) else {
 //        //print("error binding binance url")
 //        return
 //    }
 //
 //    URLSession.shared.dataTask(with: url) { (data, response, error) in
 //        guard let data = data else {
 //            //print("error binding bnc  data  parameter in URLSession")
 //            return
 //        }
 //
 //        do {
 //            guard let binanceCandles
 //                = try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyObject]] else {
 //                    print("error converting bnc json to array of arrays")
 //                    return
 //            }
 //
 //            globalBinanceCandles = binanceCandles
 //
 //        } catch let error {                                                                                 /// as Error { //or as NSError
 //            print("Failed to load: \(error.localizedDescription)")
 //        }
 //    }
 //    .resume()
 //}
 */

