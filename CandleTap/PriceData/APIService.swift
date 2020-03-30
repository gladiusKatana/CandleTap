/*🔥CandleTap_APIService💧*/import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseKrakenUrl = "https://api.kraken.com/0/public/OHLC?pair="///ie https://api.kraken.com/0/public/OHLC?pair=XXBTZCAD&since=0
    // ** cache data; use historical for kraken (for greater accuracy)
    
    func getFeeds(toPlot: ExchangeID) {                             //print("-----------------------getting feeds for exchange \(exchangeID)")
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(
        deadline: .now()) { [weak self] in                          ///DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            
            self?.getKrakenFeed { responses in                      ///ApiService.sharedInstance.getKrakenFeed { (ohlcChunks) in
                krakenApiResponses = responses  ///print("...kraken last timestamp: \(String(describing: krakenOHLCChunks?.last!.result!.last))")
                if let krakenBtcPrices = krakenApiResponses?[0].result?.XXBTZUSD { //.result?.XXBTZCAD {
                    
                    if toPlot == .kraken
                        //&& !chartFirstSetup//*
                    {candleSubset = krakenBtcPrices}
                    
                    latestKrakenXBTZCAD = Double("\(krakenBtcPrices.last![4])")!   //; print("kraken price: \(latestKrakenXBTZCAD)")
                    /**/
                } else {print("no result from Kraken API call")}
            }
            
            fetchBinanceDirectFeedForUrlString(urlString: "https://www.binance.com/api/v1/klines?symbol=ETHBTC&interval=1m")
            
            if let ethBtcCurrent = globalBinanceCandles.last?[1] {
                latestBinanceETHBTC = Double("\(ethBtcCurrent)")!       ///; print("binance price: \(latestBinanceETHBTC)")
            } ///else {print("could not cast binance price as Double")}
            
            binanceCandleSubset = globalBinanceCandles
            
            if toPlot == .binance
                //&& !chartFirstSetup
            {candleSubset = binanceCandleSubset}
            
            self?.getShakepayFeed { responses in     //getShakepayCandle(urlString: "https://api.shakepay.co/rates")
                shakepayApiResponses = responses
                let shkpPrice = "\(shakepayApiResponses!.last!.BTC_CAD!)"
                latestShakepayBTCCAD = Double("\(shkpPrice)")!                              ///; print("shakepay price: \(latestShakepayBTCCAD)")
                historicalShakepayPrices.append(latestShakepayBTCCAD)
            }
            
            currentPrices = [latestShakepayBTCCAD, latestKrakenXBTZCAD, latestBinanceETHBTC]
        }
        
        processCandleSubset()
    }
    
    func processCandleSubset() {
        if candleSubset.count > candlesToPlot {
            updateMovingAverages(maLength: 10, plottingInterval: candlesToPlot, ohlcs: candleSubset)
            //candleSubset.removeFirst(candleSubset.count - candlesToPlot)       //; print("kraken candle count: \(candleSubset.count)")
            
            if chartDisplayed { //assignCandleSubset()
                chartVC.getChart()
            }
        }
        
        var i=0
        for _/*candle*/ in candleSubset {
            
            /*let open = Double("\(candle[1])")!
             let high = Double("\(candle[2])")!
             let low = Double("\(candle[3])")!
             let close = Double("\(candle[4])")!
             
             let ohlcString = "[\(open), \(high), \(low), \(close)]"
             if !krakenUpdated {print("OHLC: \(ohlcString)")}*/
            
            if i == candleSubset.count - 1 { //print("last ohlc of this refresh")
                chartFirstSetup = true
            }
            
            i += 1
        }
    }
}

