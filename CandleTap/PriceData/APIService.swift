/*🔥CandleTap_APIService💧*/import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseUrl = "https://api.kraken.com/0/public/OHLC?pair="          ///ie  https://api.kraken.com/0/public/OHLC?pair=XXBTZCAD&since=0
    
    @objc func getFeeds() {                                             // ** cache data
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(           /// was .userInteractive
        deadline: .now()) { [weak self] in                              ///DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            
            getBinanceCandles(urlString: "https://www.binance.com/api/v1/klines?symbol=ETHBTC&interval=1m")
            
            if let ethBtcCurrent = globalBinanceCandles.last?[1] {
                latestBinanceETHBTC = Double("\(ethBtcCurrent)")!                           ///; print("binance price: \(latestBinanceETHBTC)")
            } ///else {print("could not cast binance price as Double")}
            
            self?.getKrakenFeed { responses in                          ///ApiService.sharedInstance.getKrakenFeed { (ohlcChunks) in
                krakenApiResponses = responses                          ///print("...kraken last timestamp: \(String(describing: krakenOHLCChunks?.last!.result!.last))")
                
                if let krakenBtcPrices = krakenApiResponses?[0].result?.XXBTZCAD {
                    
                    latestKrakenPrices = krakenBtcPrices                                    ///print("last Kraken OHLC: \(krakenLatestPrices.last ?? [])")
                    
                    krakenCandleSubset = latestKrakenPrices
                    krakenCandleSubset.removeFirst(krakenCandleSubset.count - 13 * 7)       ///; print("kraken ohlc lengths: \(krakenCandleSubset[0].count)")
                    
                    if let last = latestKrakenPrices.last {
                        if krakenLatestOhlc != krakenPreviousOhlc {
                            krakenLatestOhlc = [Double("\(last[1])")!, Double("\(last[2])")!, Double("\(last[3])")!, Double("\(last[4])")!]
                            krakenPreviousOhlc = krakenLatestOhlc
                        } ///else {print(".", terminator: "")}
                    } else {print("could not get .last of kraken array")}
                    
                } else {print("no result from Kraken API call")}
                
                if let btcCadCurrent = krakenApiResponses?[0].result?.XXBTZCAD!.last![4] {
                    latestKrakenXBTZCAD = Double("\(btcCadCurrent)")!                       ///; print("kraken price: \(latestKrakenXBTZCAD)")
                } ///else {print("could not cast kraken price as Double")}
            }
            
            self?.getShakepayFeed { responses in     //getShakepayCandle(urlString: "https://api.shakepay.co/rates")
                shakepayApiResponses = responses
                let shkpPrice = "\(shakepayApiResponses!.last!.BTC_CAD!)"
                latestShakepayBTCCAD = Double("\(shkpPrice)")!                              ///; print("shakepay price: \(latestShakepayBTCCAD)")
                historicalShakepayPrices.append(latestShakepayBTCCAD)
            }
            
            currentPrices = [latestShakepayBTCCAD, latestKrakenXBTZCAD, latestBinanceETHBTC]
        }
    }
}

