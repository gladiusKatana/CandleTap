/*🔥CandleTap_TradingVars💧*/import UIKit


var chartFrame = CGRect(x: 0, y: 0, width: 0, height: 0)

var chartViewWidth = CGFloat(0); var chartViewHeight = CGFloat(0)

var chartBorder = ChartRectangle(frame: zeroFrame)



var candle = Bar(frame: zeroFrame);     var bottomWick = Bar(frame: zeroFrame);     var topWick = Bar(frame: zeroFrame)

var candleSubset = [[AnyObject]]()

var candlesToPlot = 50

var candleGap = CGFloat(1)

var candleWidth = CGFloat(0)

var chartMarginY = CGFloat(0);          var chartMarginX = CGFloat(0);      var chartVerticalCushion = CGFloat(0)



//MARK: Moving Averages

var MAValues = [Double]()

var previousX = CGFloat(0);             var previousY = CGFloat(0)

var maSubsets = [[Double]]()

//var maPrintBoolLock = false




var chartDisplayed = false
//var chartFirstSetup = false

