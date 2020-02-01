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
    
    let plottingInterval = 25 //3 * 7
    
    let maLength = 10
    
    binanceCandleSubset = globalBinanceCandles                                                  ///; print("binance candles to plot: \(binanceCandleSubset)")
    updateMovingAverages(maLength: maLength,
                         plottingInterval: plottingInterval, ohlcs: globalBinanceCandles)
    
    binanceCandleSubset.removeFirst(binanceCandleSubset.count - plottingInterval)               ///print(binanceCandles)
    ///print("binance ohlc lengths: \(binanceCandleSubset[0].count)")   ///print("\(binanceCandleSubset.count) candles plotted")
    
    switch lastTappedCoordinate {
    case krakenCoordinate: candleSubset = krakenCandleSubset
    case binanceCoordinate: candleSubset = binanceCandleSubset
    default: candleSubset = binanceCandleSubset /// soon will make the default chart that of XBTCAD, daily (most likely from Kraken), once dynamic timescale selection is enabled.  (Binance's ETHBTC is plotted currently by default now only because its public API is the only one used here that provides minute timescales)
    }
    
}

