/*🔥CandleTap_Binance💧*/import UIKit

func fetchBinanceDirectFeedForUrlString(urlString: String) {                                                //print("fetching binance")
    
    guard let url = URL(string: urlString) else {
        //print("error binding binance url")
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            //print("error binding bnc  data  parameter in URLSession")
            return
        }
        
        do {
            guard let binanceCandles
                = try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyObject]] else {
                    print("error converting bnc json to array of arrays")
                    return
            }
            
            globalBinanceCandles = binanceCandles
            
        } catch let error {                                                                                 /// as Error { //or as NSError
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    .resume()
}

