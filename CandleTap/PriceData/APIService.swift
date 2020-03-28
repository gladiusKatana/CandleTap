/*🔥CandleTap_APIService💧*/import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseKrakenUrl = "https://api.kraken.com/0/public/OHLC?pair="///ie https://api.kraken.com/0/public/OHLC?pair=XXBTZCAD&since=0
    // ** cache data; use historical for kraken
    
    func getFeeds(toPlot: ExchangeID) {                             //print("-----------------------getting feeds for exchange \(exchangeID)")
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(
        deadline: .now()) { [weak self] in                          ///DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            
            self?.getKrakenFeed { responses in                      ///ApiService.sharedInstance.getKrakenFeed { (ohlcChunks) in
                krakenApiResponses = responses  ///print("...kraken last timestamp: \(String(describing: krakenOHLCChunks?.last!.result!.last))")
                if let krakenBtcPrices = krakenApiResponses?[0].result?.XXBTZUSD { //.result?.XXBTZCAD {
                    
                    if toPlot == .kraken
                        && !krakenUpdated
                    {
                        candleSubset = krakenBtcPrices
                    }
                    
                    latestKrakenXBTZCAD = Double("\(krakenBtcPrices.last![4])")!   //; print("kraken price: \(latestKrakenXBTZCAD)")
                    /**/
                } else {print("no result from Kraken API call")}
            }
            
            fetchBinanceDirectFeedForUrlString(urlString: "https://www.binance.com/api/v1/klines?symbol=ETHBTC&interval=1m")
            
            if let ethBtcCurrent = globalBinanceCandles.last?[1] {
                latestBinanceETHBTC = Double("\(ethBtcCurrent)")!       ///; print("binance price: \(latestBinanceETHBTC)")
            } ///else {print("could not cast binance price as Double")}
            
            binanceCandleSubset = globalBinanceCandles
            
            if toPlot == .binance {candleSubset = binanceCandleSubset}
            
            
            self?.getShakepayFeed { responses in     //getShakepayCandle(urlString: "https://api.shakepay.co/rates")
                shakepayApiResponses = responses
                let shkpPrice = "\(shakepayApiResponses!.last!.BTC_CAD!)"
                latestShakepayBTCCAD = Double("\(shkpPrice)")!                              ///; print("shakepay price: \(latestShakepayBTCCAD)")
                historicalShakepayPrices.append(latestShakepayBTCCAD)
            }
            
            currentPrices = [latestShakepayBTCCAD, latestKrakenXBTZCAD, latestBinanceETHBTC]
        }
        
        processCandleSubset()
        
        if chartDisplayed { //assignCandleSubset()
            chartVC.getChart()
        }
    }
    
    func processCandleSubset() {
        if candleSubset.count > candlesToPlot {
            updateMovingAverages(maLength: 10, plottingInterval: candlesToPlot, ohlcs: candleSubset)
            candleSubset.removeFirst(candleSubset.count - candlesToPlot)       //; print("kraken candle count: \(candleSubset.count)")
        }
        
        var i=0
        for _/*candle*/ in candleSubset {
//            let open = Double("\(candle[1])")!
//            let high = Double("\(candle[2])")!
//            let low = Double("\(candle[3])")!
//            let close = Double("\(candle[4])")!
            
//            let ohlcString = "[\(open), \(high), \(low), \(close)]"
//            if !krakenUpdated {print("OHLC: \(ohlcString)")}
            
            if i == candleSubset.count - 1 { //print("last ohlc of this refresh")
                if exchangeID == .kraken {krakenUpdated = true}
            }
            
            i += 1
        }
    }
}

/*
 //                    let last = krakenApiResponses?[0].result?.last          ; print("kraken latest timestamp: \(last)")
 
 //                    if let last = krakenBtcPrices.last {
 //
 ////                        if !krakenUpdated {
 //
 //                            candleSubset = krakenBtcPrices                //; print("last Kraken OHLC: \(candleSubset.last ?? [])")
 //
 ////                            candleSubset.removeLast()
 //
 ////                            krakenUpdated = true
 ////                        } else {
 //
 ////                            krakenLatestOhlcWithTimestamp = [Double("\(last[0])")!, Double("\(last[1])")!, Double("\(last[2])")!, Double("\(last[3])")!, Double("\(last[4])")!]
 ////                            if krakenLatestOhlcWithTimestamp != krakenPreviousOhlcWithTimestamp {
 //
 //
 ////                            krakenLatestTimeStamp = Double("\(last[0])")!
 ////
 ////                            if krakenPreviousTimestamp != krakenLatestTimeStamp {
 ////                                candleSubset.removeFirst()
 ////                                candleSubset.append(last)
 ////
 //////                                krakenPreviousOhlcWithTimestamp = krakenLatestOhlcWithTimestamp
 ////                                krakenPreviousTimestamp = krakenLatestTimeStamp
 ////
 ////                            } //else {print("\nkraken previous = current ohlc\n")}
 //
 ////                        }
 //
 //                        //print("kraken candle count: \(candleSubset.count)")
 //
 ////                        krakenLast = "\(last[0])"
 //
 //                    } else {print("could not get .last of kraken array")}
 */
