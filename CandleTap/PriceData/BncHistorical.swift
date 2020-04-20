/*🔥CandleTap_BinanceHistorical💧*/import UIKit

func fetchBinanceHistoricalOHLCs(ticker: String, startTime: Int64) {        //print("historical binance fetch")
    
    let urlString = "https://api.binance.com/api/v1/klines?symbol=\(ticker)&interval=1d&startTime=\(startTime)"
    guard let url = URL(string: urlString) else {/*print("error binding binance url; ")*/return}
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {/*print("error binding bnc  data  parameter in URLSession; ")*/return}
        
        do {
            guard let binanceCandles
                = try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyObject]] else {
                    print("error converting bnc historical json to array of arrays")
                    return
            }
            
            if binanceCandles.count > 1 {
                var i=0                                                    //; print("\nbinance candle count is \(binanceCandles.count)\n")
                for _ in 0 ... binanceCandles.count - 2 {
                    let arr = binanceCandles[i]
                    //let timestamp = Double("\(array[0])")!                  //; print("timestamp = \(timestamp)")
                    let open = Double("\(arr[1])")!                       //; print("open = \(open)")
                    let high = Double("\(arr[2])")!                       //; print("high = \(high)")
                    let low = Double("\(arr[3])")!                        //; print("low = \(low)")
                    let close = Double("\(arr[4])")!                      //; print("close = \(close)")
                    binanceETHBTCHistoricalForPrinting[0].append([arr[1],arr[2],arr[3],arr[4]])
                    binanceETHBTCHistorical[0].append([Double(i), open,high,low,close])
                    i += 1
                }
            }
            
            let lastTimestamp = Int64("\(binanceCandles.last!.first!)")!
            if lastTimestamp != lastHistoricalTimestamp {   print("> historical batch \(historicalBatch) ending at \(lastTimestamp)")
                /**/
                //let newlinedCandles = binanceCandles.map {"\($0)"}.joined(separator: "\n")
                //print("\n\(binanceCandles.count) historical candles starting @ 0:\n\(newlinedCandles)", terminator: "\n")
                historicalBatch += 1                        ; print("----------------------------------------------------------")
                fetchBinanceHistoricalOHLCs(ticker: ticker, startTime: lastTimestamp/* + 86400*/)
                lastHistoricalTimestamp = lastTimestamp
            } else { print("ok done pulling historical data")
                let newlinedOhlcs = binanceETHBTCHistoricalForPrinting[0].map {"\($0)"}.joined(separator: "\n") // array index depends on timescale
                print("\n\(binanceETHBTCHistoricalForPrinting[0].count) historical ohlcs:\n\n\(newlinedOhlcs)", terminator: "\n")
            }
            
        } catch let error {
            print("Failed to load: \(error.localizedDescription)")
        }
    } .resume()
}

/*
 //date-checker
 //                let day500 = makeDateFrom(year: 2018, month: 11, day: 25, hr: -5, min: 0, sec: 0)
 //                print("...& the last timestamp is \(Int64((day500.timeIntervalSince1970 * 1000.0).rounded()))")
 //                print("...& the last date is \(formattedDateString(day500, roundedDown: false, showYear: true, prefix: "", suffix: "", dateFormat: .fullDay))")
 */

