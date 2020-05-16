/*🔥CandleTap_BinanceHistorical💧*/import UIKit

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
            
            nineSampleSize = 73 ; candlesToPlot = nineSampleSize + 1 // try to refactor out this offset by 1
            var paddingCSV: [AnyObject] = []; for _ in 1...18 {paddingCSV.append("0" as AnyObject)}
            
            for _ in MAPeriod.allCases {maSubsets.append([])}                   //; print("we have \(maSubsets.count) moving averages")
            
            if binanceCandles.count > 1 {
                
                var lastFiveCloses = [Double]()
                var i=0                                                         //; print("\nbinance candle count is \(binanceCandles.count)\n")
                
                for _ in 0 ... binanceCandles.count - 2 {
                    let arr = binanceCandles[i]
                    let timestamp = "\(arr[0])" as AnyObject                    //; print("timestamp = \(timestamp)")
                    let dot = "." as AnyObject
                    let close = Double("\(arr[4])")!                            //; print("close = \(close)")
                    
                    
                    if lastFiveCloses.count == 5 {lastFiveCloses.removeFirst()} //🟥🟩for Sequential
                    if lastFiveCloses.count <= 5 {lastFiveCloses.append(close)} //"            "
                    
                    var (count, colourString) : (Int?,String) = (0,"")
                    if i >= 4 {
                        (count, colourString) = sequentialHistorical(lastFiveCloses: lastFiveCloses)
                    } //else {print("\n")}
                    
                    let countAndColour = "\(colourString)\(count ?? 0)"
                    if countAndColour == "R9" { redNines += 1 /*; print("RED 9!")*/ }
                    if countAndColour == "G9" { greenNines += 1 /*; print("GREEN 9!")*/ }
                    
                    let cnt = "\(count ?? 0)" as AnyObject
                    let clrString = "\(colourString)" as AnyObject              //🟩🟥
                    
                    
                    let ohlcPlusSeq = [arr[1],arr[2],arr[3],arr[4],countAndColour] as [AnyObject]
                    binanceHistoricalForPrinting.append([ohlcPlusSeq]) //print(ohlcPlusSeq)
                    
                    
                    var preCsv = [timestamp,dot,arr[1],arr[2],arr[3],arr[4],cnt,clrString]          //; print("\n-----------------(\(i))")
                    let movingAverages = historicalMAs(latestClose: close)
                    for avg in movingAverages {
                        preCsv.append("\(avg)" as AnyObject)
                    }
                    //let grnNines = "\(greenNines)" as AnyObject ; let rdNines = "\(redNines)" as AnyObject
                    //preCsv.append(grnNines); preCsv.append(rdNines) // just used as (yet another) way to double check the number of nines
                    if i == 0 {padHistoricalOHLCs([paddingCSV], size: nineSampleSize)}
                    binanceHistorical.append([preCsv])
                    
                    i += 1
                }
            }
            
            let lastTimestamp = Int64("\(binanceCandles.last!.first!)")!
            if lastTimestamp != lastHistoricalTimestamp {                       //print("> hist. batch \(historicalBatch) ending at \(lastTimestamp)")
                
                historicalBatch += 1                                            //; print("----------------------------------------------------------")
                fetchBinanceHistoricalOHLCs(ticker: ticker, interval: interval, startTime: lastTimestamp/* + 86400*/)
                lastHistoricalTimestamp = lastTimestamp
                
            } else {                                                            //print("ok done pulling historical data")
                let ohlcsToPrint = binanceHistorical//ForPrinting
                let candleCount = ohlcsToPrint.count                            //; print("\n\(candleCount) historical ohlcs (before padding)")
                
                //let newlinedOhlcs = ohlcsToPrint.map {"\($0)"}.joined(separator: "\n")
                //print("\n\(candleCount) historical ohlcs (before padding):\n\n\(newlinedOhlcs)", terminator: "\n")
                
                let firstHistoricalOhlc = binanceHistorical.first?.first  // or .first?.last as the [[[]]] has 1 item only thus is a [[]] thus far
                padHistoricalOHLCs([firstHistoricalOhlc!], size: nineSampleSize)
                
                let count = binanceHistorical.count
                print("\(count) ohlcs: \(count - nineSampleSize) historical, \(nineSampleSize) padding")
                
                findAndPlotNinesAndNeighbouringCandles(size: nineSampleSize)
                
                displayNineFrequency(candleCount: candleCount)
                
                candleSubset = nineCenteredOHLCs[nineChartIndex]
                
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    pairListVC.gotoView(vc: chartVC)
//                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    pairListVC.presentEmail()
                }
                
            }
        } catch let error {print("Failed to load: \(error.localizedDescription)")}
    } .resume()
}

func padHistoricalOHLCs(_ paddingArray: [[AnyObject]], size: Int) {
    for _ in 1...size {
        binanceHistorical.append(paddingArray)      // pad the historical ohlcs (for now), to catch all the 9s
    }
}

