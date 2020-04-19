/*🔥CandleTap_BinanceHistorical💧*/import UIKit

extension ApiService {
    func binanceHistoricalFetch(startTime: Int64) { //(startTime: Int64, completion: @escaping ([BinanceLatestPrice]) -> ()) {
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
            
            for array in binanceCandles {
                let timestamp = Double("\(array[0])")!                  //; print("timestamp = \(timestamp)")
                let open = Double("\(array[1])")!                       //; print("open = \(open)")
                let high = Double("\(array[2])")!                       //; print("high = \(high)")
                let low = Double("\(array[3])")!                        //; print("low = \(low)")
                let close = Double("\(array[4])")!                      //; print("close = \(close)")
                binanceETHBTCHistorical[0].append([open,high,low,close])
            }
            
            let lastTimestamp = Int64("\(binanceCandles.last!.first!)")!
            
            if lastTimestamp != lastHistoricalTimestamp {
                
                print("> historical batch \(historicalBatch) ending at \(lastTimestamp)")
                /**/
                historicalBatch += 1
                
                //let newlinedCandles = binanceCandles.map {"\($0)"}.joined(separator: "\n")
                //print("\n\(binanceCandles.count) historical candles starting @ 0:\n\(newlinedCandles)", terminator: "\n")
                print("----------------------------------------------------------")
                
                apiServ.binanceHistoricalFetch(startTime: lastTimestamp/*, completion: {responses in }*/)
                lastHistoricalTimestamp = lastTimestamp
            }
            else { print("ok done pulling historical data")
                let newlinedOhlcs = binanceETHBTCHistorical[0].map {"\($0)"}.joined(separator: "\n") // array index depends on timescale
                print("\n\(binanceETHBTCHistorical[0].count) historical ohlcs:\n\n\(newlinedOhlcs)", terminator: "\n")
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

/*
 //date-checker
 //                let day500 = makeDateFrom(year: 2018, month: 11, day: 25, hr: -5, min: 0, sec: 0)
 //                print("...& the last timestamp is \(Int64((day500.timeIntervalSince1970 * 1000.0).rounded()))")
 //                print("...& the last date is \(formattedDateString(day500, roundedDown: false, showYear: true, prefix: "", suffix: "", dateFormat: .fullDay))")
 */

