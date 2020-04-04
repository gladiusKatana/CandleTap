/*🔥CandleTap_TradingVars💧*/import UIKit

var candleSubset = [[AnyObject]]();                 var candlesToPlot = 25

var historicalShakepayPrices = [Double]()

var candleGap = CGFloat(1)
var candleWidth = CGFloat(0)
var chartMarginY = CGFloat(0);                      var chartMarginX = CGFloat(0)
var chartVerticalCushion = CGFloat(0)

var lastTappedCoordinate = [-1,-1];                 var chartCoordinates = [[1,1],[1,2]]
var krakenCoordinate = [1,1]
var binanceCoordinate = [1,2]




var chartFrame = CGRect(x: 0, y: 0, width: 0, height: 0)

var chartViewWidth = CGFloat(0); var chartViewHeight = CGFloat(0)

var chartBorder = PlotRectange(frame: zeroFrame)

var candle = Bar(frame: zeroFrame)
var bottomWick = Bar(frame: zeroFrame)
var topWick = Bar(frame: zeroFrame)

var maPoint = Bar(frame: zeroFrame)

var chartDisplayed = false



//var maLine = LineView(frame: zeroFrame)

var movingAverageLength = 100

var MAValues = [Double]()

var maXcoord1 = 10.0; var maXcoord2 = 30.0
var maYcoord1 = 10.0; var maYcoord2 = 10.0
var previousX = CGFloat(0); var previousY = CGFloat(0)

var maPrintBoolLock = false

var globalBinanceCandles = [[AnyObject]]()
