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

extension ApiService {
//    func binanceHistoricalFetch(startTime: Int64, completion: @escaping ([BinanceLatestPrice]) -> ()) {
//        fetchBinanceHistoricalOHLCs(urlString: "https://api.binance.com/api/v1/klines?symbol=ETHBTC&interval=1d&startTime=\(startTime)", completion: completion)
//    }
    
    func binanceHistoricalFetch(startTime: Int64) {
        fetchBinanceHistoricalOHLCs(urlString: "https://api.binance.com/api/v1/klines?symbol=ETHBTC&interval=1d&startTime=\(startTime)")
    }
}

func fetchBinanceHistoricalOHLCs(urlString: String) {   //print("historical binance fetch")
    
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
                    print("error converting bnc historical json to array of arrays")
                    return
            }
            
            historicalBinanceCandles = binanceCandles
            
            let lastTimestamp = Int64("\(historicalBinanceCandles.last!.first!)")!
            
            if lastTimestamp != lastHistoricalTimestamp {
                
                print("> historical batch \(historicalBatch) ending at \(lastTimestamp)")
                
//                let day500 = makeDateFrom(year: 2018, month: 11, day: 25, hr: -5, min: 0, sec: 0)
//                print("...& the last timestamp is \(Int64((day500.timeIntervalSince1970 * 1000.0).rounded()))")
//                print("...& the last date is \(formattedDateString(day500, roundedDown: false, showYear: true, prefix: "", suffix: "", dateFormat: .fullDay))")
                
                historicalBatch += 1
                
                //let newlinedCandles = historicalBinanceCandles.map {"\($0)"}.joined(separator: "\n")
                //print("\n\(historicalBinanceCandles.count) historical candles starting @ 0:\n\(newlinedCandles)", terminator: "\n")
                print("----------------------------------------------------------")
                
                apiServ.binanceHistoricalFetch(startTime: lastTimestamp/*, completion: {responses in }*/)
                lastHistoricalTimestamp = lastTimestamp
            }
            
        } catch let error {                                                                                 /// as Error { //or as NSError
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    .resume()
}

func makeDateFrom(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> Date {
    let calendar = Calendar(identifier: .gregorian)
    // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
    return calendar.date(from: components)!
}

