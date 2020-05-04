/*🔥CandleTap_BinanceHistorical💧*/import UIKit

var nineVicinityOhlcs = [[AnyObject]]()

func fetchBinanceHistoricalOHLCs(ticker: String, interval: Timescale, startTime: Int64) {        //print("historical binance fetch")
    
    let urlString = "https://api.binance.com/api/v1/klines?symbol=\(ticker)BTC&interval=\(interval.urlSymbol())&startTime=\(startTime)"
    guard let url = URL(string: urlString) else {/*print("error binding binance url; ")*/return}
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {/*print("error binding bnc  data  parameter in URLSession; ")*/return}
        
        do {
            guard let binanceCandles
                = try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyObject]] else {
                    print("error converting bnc historical json to array of arrays")
                    return
            }
            
            for _ in MAPeriod.allCases {maSubsets.append([])}                   //; print("we have \(maSubsets.count) moving averages")
            
            if binanceCandles.count > 1 {
                
                var lastFiveCloses = [Double]()
                var i=0                                                         //; print("\nbinance candle count is \(binanceCandles.count)\n")
                
                for _ in 0 ... binanceCandles.count - 2 {
                    let arr = binanceCandles[i]
                    let timestamp = "\(arr[0])" as AnyObject                    //; print("timestamp = \(timestamp)")
                    let dot = "." as AnyObject
                    let close = Double("\(arr[4])")!                            //; print("close = \(close)")
                    /**/
                    
                    if lastFiveCloses.count == 5 {lastFiveCloses.removeFirst()} //for Sequential -------------------------------------------🟥🟩
                    if lastFiveCloses.count <= 5 {lastFiveCloses.append(close)} //"            "
                    
                    var (count, colourString) : (Int?,String) = (0,"")
                    if i >= 4 {
                        (count, colourString) = sequentialHistorical(lastFiveCloses: lastFiveCloses)
                    } //else {print("\n")}
                    
                    let countAndColour = "\(colourString)\(count ?? 0)"
                    if countAndColour == "R9" { redNines += 1 /*; print("RED 9!")*/ }
                    if countAndColour == "G9" { greenNines += 1 /*; print("GREEN 9!")*/ }
                    
                    let cnt = "\(count ?? 0)" as AnyObject      ; let clrString = "\(colourString)" as AnyObject
                    let grnNines = "\(greenNines)" as AnyObject ; let rdNines = "\(redNines)" as AnyObject //-----------------------------🟩🟥
                    
                    
                    let ohlcPlusSeq = [arr[1],arr[2],arr[3],arr[4],countAndColour] as [AnyObject]
                    binanceETHBTCHistoricalForPrinting.append([ohlcPlusSeq]) //print(ohlcPlusSeq)
                    i += 1
                    
                    
                    var preCsv = [timestamp,dot,arr[1],arr[2],arr[3],arr[4],cnt,clrString]
                    let movingAverages = historicalMAs(latestClose: close)
                    for avg in movingAverages {
                        preCsv.append("\(avg)" as AnyObject)
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
                let candleCount = ohlcsToPrint.count                        //; print("\n\(candleCount) historical ohlcs (before padding)")
                
                let newlinedOhlcs = ohlcsToPrint.map {"\($0)"}.joined(separator: "\n")
                print("\n\(candleCount) historical ohlcs (before padding):\n\n\(newlinedOhlcs)", terminator: "\n")
                
                let size = 73
                
                let firstHistoricalOhlc = binanceETHBTCHistorical.first?.first // or .first?.last as the [[[]]] has 1 item only thus is a [[]] thus far
                for _ in 1...size {
                    binanceETHBTCHistorical.append([firstHistoricalOhlc!])     // pad the historical ohlcs (for now), to catch all the 9s
                }
                
                for ohlc in binanceETHBTCHistorical {
                    let ohlcZero = ohlc[0]
                    let ohlcPlusSeq = [ohlcZero[2],ohlcZero[3],ohlcZero[4],ohlcZero[5],ohlcZero[6],ohlcZero[7]] //open,high,low,close,seq,colour
                    
                    if nineVicinityOhlcs.count == size { nineVicinityOhlcs.removeFirst() }       //for Sequential : analyzing neighbourhood of 9's
                    if nineVicinityOhlcs.count <= size { nineVicinityOhlcs.append(ohlcPlusSeq) } //"                                             "
                    
                    if nineVicinityOhlcs.count == size {
                        if "\(nineVicinityOhlcs[10][4])" == "9" {                                //print("there's a 9!")
                            if "\(nineVicinityOhlcs[10][5])" == "G" {chartGreenNines += 1}       //print("there's a green 9!")
                            if "\(nineVicinityOhlcs[10][5])" == "R" {chartRedNines += 1}         //print("there's a red 9!")
                        }
                    }                                                                            //; print(ohlcPlusSeq)
                }
                
                /*let newlinedNineVicinity = nineVicinityOhlcs.map {"\($0)"}.joined(separator: "\n")
                 print("\n\(nineVicinityOhlcs.count) candles ((around a 9)):\n\n\(newlinedNineVicinity)", terminator: "\n")*/
                
                /*let newlinedPaddedOhlcs = binanceETHBTCHistorical.map {"\($0)"}.joined(separator: "\n")
                 print("\n\(binanceETHBTCHistorical.count) historical ohlcs (incl. \(size) as padding):\n\n\(newlinedPaddedOhlcs)", terminator: "\n")*/
                
                let count = binanceETHBTCHistorical.count
                print("\n\(count) ohlcs: \(count-size) historical, \(size) padding")
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    pairListVC.presentEmail()
                    displayNineFrequency(candleCount: candleCount)
                }
            }
        } catch let error {print("Failed to load: \(error.localizedDescription)")}
    } .resume()
}

/*let sizeExcess = str.count - 12
 if sizeExcess >= 0 {
 str.removeLast(sizeExcess)
 }*/

/*
 //                    let open = Double("\(arr[1])")!                               //; print("open = \(open)")
 //                    let high = Double("\(arr[2])")!                               //; print("high = \(high)")
 //                    let low = Double("\(arr[3])")!                                //; print("low = \(low)")
 */

/*
 //date-checker
 //                let day500 = makeDateFrom(year: 2018, month: 11, day: 25, hr: -5, min: 0, sec: 0)
 //                print("...& the last timestamp is \(Int64((day500.timeIntervalSince1970 * 1000.0).rounded()))")
 //                print("...& the last date is \(formattedDateString(day500, roundedDown: false, showYear: true, prefix: "", suffix: "", dateFormat: .fullDay))")
 */
