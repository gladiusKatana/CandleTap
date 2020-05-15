/*🔥CandleTap_KrakenHistorical💧*/import UIKit

func fetchKrakenHistoricalOHLCs(ticker: String, interval: Timescale, startTime: Int64,
                                completion: @escaping ([KrakenApiResponse]) -> ()) {        //print("historical binance fetch")
    
    let urlString = "https://api.kraken.com/0/public/Trades?pair=\(ticker)&interval=\(interval.urlSymbol())&since=\(startTime)"
    
    guard let url = URL(string: urlString) else {/*print("error binding kraken url; ")*/return}
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            //print("error binding krk  data  parameter in URLSession")
            return
        }
        
        do {
            guard let jsonDictionaries
                = try [JSONSerialization.jsonObject(with: data, options: .mutableContainers)] as? [[String: AnyObject]] else {
                    print("error converting krk json to array of dictionaries")
                    return
            }
            
            completion(jsonDictionaries.map({return KrakenApiResponse(dictionary: $0)}))
            
            /*
            //        do {
            //            guard let krakenCandles
            //                = try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyObject]] else {
            //                    print("error converting krk historical json to array of arrays")
            //                    return
            //            }
        
            
//            if krakenCandles.count > 1 {
//
//                var i=0                                                 //; print("\nbinance candle count is \(binanceCandles.count)\n")
//
//                for _ in 0 ... krakenCandles.count - 2 {                //                              type       orderType
//                    let arr = krakenCandles[i]                          //<price>, <volume>, <time>, <buy/sell>, <market/limit>,  <miscellaneous>
//
//                    let dot = "." as AnyObject
//
//                    let price = arr[0]      //Double("\(arr[0])")!
//                    let volume = arr[1]     //Double("\(arr[1])")!
//                    let time = arr[2]       //Double("\(arr[2])")!
//                    let type = arr[3]       //Double("\(arr[3])")!
//                    let orderType = arr[4]  //Double("\(arr[4])")!
//
//                    let preCsv = [price,volume,time,dot,type,orderType]
//                    krakenETHBTCHistorical.append([preCsv])
//
//                    i += 1
//                }
//
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                pairListVC.presentEmail()
//            }
            */
            
            
        } catch let error {print("Failed to load: \(error.localizedDescription)")}
    } .resume()
}

