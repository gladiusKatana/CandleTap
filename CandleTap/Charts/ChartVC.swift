/*🔥CandleTap_ChartVC💧*/import UIKit

class ChartVC: UIViewController {
    
    var viewControllerType = ViewControllerType.chart
    
    init(_ vcType: ViewControllerType) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllerType = vcType
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


func assignCandleSubset() {
    
    binanceCandleSubset = globalBinanceCandles                          ///; print("binance candles to plot: \(binanceCandleSubset)")

    /// soon will make the default chart that of XBTCAD, daily (most likely from Kraken), once dynamic timescale selection is enabled.  (Binance's ETHBTC is plotted currently by default now only because its public API is the only one used here that provides minute timescales)
    
////        let subset = binanceCandleSubset
//        let subset = krakenCandleSubset
//
//    candleSubset = subset
    
//    let plottingInterval = 20
//    let maLength = 4
    
//    candleSubset.removeFirst(candleSubset.count - plottingInterval)     //print("candle subset count: \(candleSubset.count)")
    

    
//    updateMovingAverages(maLength: maLength,
//                         plottingInterval: plottingInterval, ohlcs: candleSubset)
    
}

