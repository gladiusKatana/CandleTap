/*🔥CandleTap_Binance💧*/import UIKit

extension ApiService {
    
    func getBinanceCandles(urlString: String) {                             //print("fetching binance")
        
        guard let url = URL(string: urlString) else {
            print("error with url")
            return
        }                                                                   //; print("ok the url is \(url)")
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else {return}                             //; print("ok, the data is \(data)")
            
            do {
                guard let binanceCandles = try JSONSerialization.jsonObject(with:
                    data, options: []) as? [[AnyObject]] else {             print("error binding binance json data (without keys) to array of arrays")
                        return
                }                                                           //; print("ok, the json data is \(binanceCandle)")
                
                globalBinanceCandles = binanceCandles
                
            } catch let error {                                             // as Error { //or as NSError
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        .resume()
    }
}

/*class BinanceChunk: SafeJsonObject {
 //    @objc var
 }*/

//func fetchBinanceFeedForUrlString(urlString: String, completion: @escaping ([BinanceChunk]) -> ()) { print("fetching binance")
//    guard let url = URL(string: urlString) else { print("error binding binance url")
//        return}
//
//    URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
//        guard let data = data else { print("error binding binance  data  parameter in URLSession")
//            return}
//        do {
//            guard let jsonDictionaries = try [JSONSerialization.jsonObject(with: data, options: .mutableContainers)] as? [[String]] else { print("error binding binance json-dictionaries to array of arrays (Binance API OHLC format)")
//                return}
//
//            completion(
//                jsonDictionaries.map({
//                    return BinanceChunk(dictionary: $0)})
//            )
//        } catch let jsonSerializationError {
//            print("Error serializing json:", jsonSerializationError)
//        }
//

//        }
//        .resume()
//}

