/*🔥CandleTap_APIService💧*/import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseUrl = "https://api.kraken.com/0/public/OHLC?pair="                      ///ie  https://api.kraken.com/0/public/OHLC?pair=XXBTZCAD&since=0
    
    @objc func getFeeds() {                                                         ///print("\nGetting feeds")
        
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now()) { [weak self] in /// or . user Initiated  ?
            ///DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in      // ** cache fetched data
            self?.getKrakenFeed { (ohlcChunks) in                                   ///ApiService.sharedInstance.getKrakenFeed { (ohlcChunks) in
                krakenOHLCChunks = ohlcChunks                                               ///print("kraken chunks:\n\(String(describing: krakenOHLCChunks))")
                ///print("...kraken chunks' last timestamp: \(String(describing: krakenOHLCChunks?.last!.result!.last))")    //rename 2nd "last" here?
                
                if let krakenBtcPrices = krakenOHLCChunks?[0].result?.XXBTZCAD {
                    ///print("kraken btc prices: \(krakenBtcPrices)")  ///print("kraken candle lengths: \(krakenBtcPrices[5].count)")
                    krakenCandleSubset = krakenBtcPrices
                    krakenCandleSubset.removeFirst(krakenCandleSubset.count - 13 * 7)       ///; print("kraken ohlc lengths: \(krakenCandleSubset[0].count)")
                    
                    if let last = krakenCandleSubset.last {
                        if krakenLatestOhlc != krakenPreviousOhlc {
                            krakenLatestOhlc = [Double("\(last[1])")!, Double("\(last[2])")!, Double("\(last[3])")!, Double("\(last[4])")!]
                            krakenPreviousOhlc = krakenLatestOhlc                           ///; print("last Kraken OHLC: \(krakenLatestOhlc)")
                        } ///else {print(".", terminator: "")}
                    } else {print("could not get .last of kraken array")}                   ///print("last Kraken OHLC: \(krakenCandleSubset.last ?? [])")
                    
                } else {print("no result from Kraken API call")}
                
                if let btcCadCurrent = krakenOHLCChunks?[0].result?.XXBTZCAD!.last![4] {    /// do not use .last for chart, only for current price
                    latestKrakenXBTCAD = Double("\(btcCadCurrent)")!                        ///; print("kraken price: \(latestKrakenXBTCAD)")
                } ///else {print("could not cast kraken price as Double")}
            }
            
            self?.getShakepayFeed { (ohlcChunks) in     //getShakepayCandle(urlString: "https://api.shakepay.co/rates")
                shakepayPriceUpdates = ohlcChunks
                let shkpPrice = "\(shakepayPriceUpdates!.last!.BTC_CAD!)"
                latestShakepayBTCCAD = Double("\(shkpPrice)")!                              ///; print("shakepay price: \(latestShakepayBTCCAD)")
                historicalShakepayPrices.append(latestShakepayBTCCAD)
            }
            
            self?.getBinanceCandles(urlString: "https://www.binance.com/api/v1/klines?symbol=ETHBTC&interval=1m")
            
            if let ethBtcCurrent = globalBinanceCandles.last?[1] {
                latestBinanceETHBTC = Double("\(ethBtcCurrent)")!                           ///; print("binance price: \(latestBinanceETHBTC)")
            } ///else {print("could not cast binance price as Double")}
            
            currentPrices = [latestShakepayBTCCAD, latestKrakenXBTCAD, latestBinanceETHBTC]
        }
    }
    
    func getKrakenFeed(_ completion: @escaping ([KrakenOHLCChunk]) -> ()) {                                             /// need these wrapper functions...
        fetchKrakenFeedForUrlString(urlString: "\(baseUrl)\(krakenPair)&interval=240&since=0", completion: completion)   ///...bc. called as a closure
    }
    
    func getShakepayFeed(_ completion: @escaping ([ShakepayPriceUpdate]) -> ()) {
        fetchShakepayFeedForUrlString(urlString: "https://api.shakepay.co/rates", completion: completion)
    }
}

