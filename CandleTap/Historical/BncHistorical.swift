/*🔥CandleTap_BinanceHistorical💧*/import UIKit

func fetchBinanceHistoricalOHLCs(ticker: String, interval: Timescale, startTime: Int64) {        //print("historical binance fetch")
    
    let urlString = "https://api.binance.com/api/v1/klines?symbol=\(ticker)BTC&interval=\(interval.urlSymbol())&startTime=\(startTime)"
//    print("url string: \(urlString)")
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
                var lastFiveCloses = [Double]()
                var i=0                                                     //; print("\nbinance candle count is \(binanceCandles.count)\n")
                for _ in 0 ... binanceCandles.count - 2 {
                    let arr = binanceCandles[i]
                    let timestamp = "\(arr[0])" as AnyObject                //; print("timestamp = \(timestamp)")
                    let dot = "." as AnyObject
//                    let open = Double("\(arr[1])")!                               //; print("open = \(open)")
//                    let high = Double("\(arr[2])")!                               //; print("high = \(high)")
//                    let low = Double("\(arr[3])")!                                //; print("low = \(low)")
                    let close = Double("\(arr[4])")!                        //; print("close = \(close)")
                    
                    //-----------------------------------for Sequential
                    if lastFiveCloses.count == 5 {
                        lastFiveCloses.removeFirst()
                    }
                    if lastFiveCloses.count <= 5 {
                        lastFiveCloses.append(close)
                    }//----------------------------------
                    
                    var (count, colourString) : (Int?,String) = (0,"")
                    if i >= 4 {
                        (count, colourString) = sequentialHistorical(lastFiveCloses: lastFiveCloses)
                    } //else {print("\n")}
                    
                    let ohlcPlusSeq = [arr[1], arr[2],arr[3], arr[4], "\(colourString)\(count ?? 0)"] as [AnyObject]
                    binanceETHBTCHistoricalForPrinting.append([ohlcPlusSeq]) //print(ohlcPlusSeq)
                    i += 1
                    
                    let cnt = "\(count ?? 0)" as AnyObject
                    let clrString = "\(colourString)" as AnyObject
                    let grnNines = "\(greenNines)" as AnyObject
                    let rdNines = "\(redNines)" as AnyObject
                    
                    var preCsv = [timestamp,dot,arr[1],arr[2],arr[3],arr[4],cnt,clrString]
                    let movingAverages = historicalMAs(latestClose: close)
                    for avg in movingAverages {
                        let str = "\(avg)"
                        /*let sizeExcess = str.count - 12
                         if sizeExcess >= 0 {
                         str.removeLast(sizeExcess)
                         }*/
                        preCsv.append(str as AnyObject)
                    }
                    
                    preCsv.append(grnNines); preCsv.append(rdNines)
                    
                    binanceETHBTCHistorical.append([preCsv])
                }
            }
            
            let lastTimestamp = Int64("\(binanceCandles.last!.first!)")!
            if lastTimestamp != lastHistoricalTimestamp {                   //print("> hist. batch \(historicalBatch) ending at \(lastTimestamp)")
                /**/
                //let newlinedCandles = binanceCandles.map {"\($0)"}.joined(separator: "\n")
                //print("\n\(binanceCandles.count) historical candles starting @ 0:\n\(newlinedCandles)", terminator: "\n")
                
                historicalBatch += 1                                        //; print("----------------------------------------------------------")
                fetchBinanceHistoricalOHLCs(ticker: ticker, interval: interval, startTime: lastTimestamp/* + 86400*/)
                lastHistoricalTimestamp = lastTimestamp
                
            } else {                                                        //print("ok done pulling historical data")
                let ohlcsToPrint = binanceETHBTCHistoricalForPrinting
                let newlinedOhlcs = ohlcsToPrint.map {"\($0)"}.joined(separator: "\n")
                let candleCount = ohlcsToPrint.count
                print("\n\(candleCount) historical ohlcs:\n\n\(newlinedOhlcs)", terminator: "\n")
                
                let grnNineFreq = (100 * Double(greenNines) / Double(candleCount)).rounded(toPlaces: 2)
                let redNineFreq = (100 * Double(redNines) / Double(candleCount)).rounded(toPlaces: 2)
                print("\n\(greenNines) green nines (\(grnNineFreq) %) & \(redNines) red nines (\(redNineFreq) %) ")
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    pairListVC.presentEmail()
                }
            }
            
        } catch let error {
            print("Failed to load: \(error.localizedDescription)")
        }
    } .resume()
}

func sequentialHistorical(lastFiveCloses: [Double]) -> (Int?, String) {
    var colourString = "" //G for green, R for red
    var returnInt = 0
    
    let current = lastFiveCloses[4]
    let fourAgo = lastFiveCloses[0]
    
    if current > fourAgo {                      //print("----------Seq_is \(current) > \(fourAgo) ? YES\n")
        if reds != 0 {reds = 0}
        
        if greens == 9 {
            greens = 0
            greenNines += 1
        }
        
        greens += 1
        colourString = "G"
        returnInt = greens
    }
    else if current < fourAgo {
        if greens != 0 {greens = 0}
        
        if reds == 9 {
            reds = 0
            redNines += 1
        }
        
        reds += 1
        colourString = "R"
        returnInt = reds
    }
    else {greens = 0   ; colourString = ""}
    return (returnInt, colourString)
}

/*
 //date-checker
 //                let day500 = makeDateFrom(year: 2018, month: 11, day: 25, hr: -5, min: 0, sec: 0)
 //                print("...& the last timestamp is \(Int64((day500.timeIntervalSince1970 * 1000.0).rounded()))")
 //                print("...& the last date is \(formattedDateString(day500, roundedDown: false, showYear: true, prefix: "", suffix: "", dateFormat: .fullDay))")
 */

