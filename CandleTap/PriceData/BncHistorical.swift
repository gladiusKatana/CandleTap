/*🔥CandleTap_BinanceHistorical💧*/import UIKit

var maSubsets = [[Double]]()

func fetchBinanceHistoricalOHLCs(ticker: String, interval: Timescale, startTime: Int64) {        //print("historical binance fetch")
    
    let urlString = "https://api.binance.com/api/v1/klines?symbol=\(ticker)&interval=\(interval.urlSymbol())&startTime=\(startTime)"
    guard let url = URL(string: urlString) else {/*print("error binding binance url; ")*/return}
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {/*print("error binding bnc  data  parameter in URLSession; ")*/return}
        
        do {
            guard let binanceCandles
                = try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyObject]] else {
                    print("error converting bnc historical json to array of arrays")
                    return
            }
            
            for _ in MAPeriod.allCases {maSubsets.append([])}               //; print("we have \(maSubsets.count) moving averages")
            
            if binanceCandles.count > 1 {
                var i=0                                                     //; print("\nbinance candle count is \(binanceCandles.count)\n")
                for _ in 0 ... binanceCandles.count - 2 {
                    let arr = binanceCandles[i]
                    let timestamp = "\(arr[0])" as AnyObject                //; print("timestamp = \(timestamp)")
                    let dot = "." as AnyObject
                    let open = Double("\(arr[1])")!                         //; print("open = \(open)")
                    let high = Double("\(arr[2])")!                         //; print("high = \(high)")
                    let low = Double("\(arr[3])")!                          //; print("low = \(low)")
                    let close = Double("\(arr[4])")!                        //; print("close = \(close)")
                    
                    var ar = [timestamp,dot,arr[1],arr[2],arr[3],arr[4]]
                    let movingAverages = historicalMAs(latestClose: close)
                    for avg in movingAverages {
                        var str = "\(avg)"
//                        let sizeExcess = str.count - 12
//                        if sizeExcess >= 0 {
//                            str.removeLast(sizeExcess)
//                        }
                        ar.append(str as AnyObject)
                    }
                    
                    binanceETHBTCHistorical.append([ar])
                    binanceETHBTCHistoricalForPrinting.append([[/*rDouble(i),*/open,high,low,close]])
                    i += 1
                }
            }
            
            let lastTimestamp = Int64("\(binanceCandles.last!.first!)")!
            if lastTimestamp != lastHistoricalTimestamp {                   print("> hist. batch \(historicalBatch) ending at \(lastTimestamp)")
                /**/
                //let newlinedCandles = binanceCandles.map {"\($0)"}.joined(separator: "\n")
                //print("\n\(binanceCandles.count) historical candles starting @ 0:\n\(newlinedCandles)", terminator: "\n")
                
                historicalBatch += 1                                        ; print("----------------------------------------------------------")
                fetchBinanceHistoricalOHLCs(ticker: ticker, interval: interval, startTime: lastTimestamp/* + 86400*/)
                lastHistoricalTimestamp = lastTimestamp
            } else { //print("ok done pulling historical data")
                
                //let newlinedOhlcs = binanceETHBTCHistoricalForPrinting.map {"\($0)"}.joined(separator: "\n")
                //print("\n\(binanceETHBTCHistoricalForPrinting[0].count) historical ohlcs:\n\n\(newlinedOhlcs)", terminator: "\n")
                print("\n\n\(binanceETHBTCHistorical.count) historical ohlcs:\n\n")
                //print(newlinedOhlcs)
                
                for ohlc in binanceETHBTCHistoricalForPrinting {
                    let ohlc = ohlc[0] // index depends on timescale (0th timescale usually weeks or months... final timescale is minutes)
                    print(ohlc) //print("\(ohlc[2]),\(ohlc[3]),\(ohlc[4]),\(ohlc[5])")
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    pairListVC.presentEmail()
                }
            }
            
        } catch let error {
            print("Failed to load: \(error.localizedDescription)")
        }
    } .resume()
}

func historicalMAs(latestClose: Double) -> [Double] {
    var mas = [Double]()
    var i=0
    for period in MAPeriod.allCases {       //print("ma period to add: \(period.rawValue)")
        
        //if !maSubsets.isEmpty {
        if maSubsets[i].count == period.rawValue {
            maSubsets[i].removeFirst()
        }
        
        if maSubsets[i].count <= period.rawValue {
            maSubsets[i].append(latestClose)      //; print("appended to subset")
        }
        
        let ma = maSubsets[i].average   //; print("subset length \(period.rawValue) has \(maSubsets[i].count) values, average is \(ma)")
        //        let maRounded = 1-((1-ma).truncate(places: 8)).truncate(places: 8)//ma.rounded(toPlaces: 8)//(round(1000000*ma)/1000000)
        mas.append(ma)
        
        i+=1
        //} else {print("ma subsets empty")}
    }
    
    return mas
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

/*
//date-checker
//                let day500 = makeDateFrom(year: 2018, month: 11, day: 25, hr: -5, min: 0, sec: 0)
//                print("...& the last timestamp is \(Int64((day500.timeIntervalSince1970 * 1000.0).rounded()))")
//                print("...& the last date is \(formattedDateString(day500, roundedDown: false, showYear: true, prefix: "", suffix: "", dateFormat: .fullDay))")
*/

