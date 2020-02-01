/*🔥CandleTap_TradingVars💧*/import UIKit

//var itemAtIndexPath = Dictionary<CellIndexPath<Int,Int>,TradingPair>()      /// Dictionary lookup for arrays of tasks (ie to-do-lists), keyed by index path of collection view

//var selectedIndexPath = defaultPathOutOfView;       var previousTimeBlockPathSelected = defaultPathOutOfView /// for animations: see Tap.swift

//var defaultPathOutOfView = [-1, -1]

let apiServ = ApiService()
var candleSubset = [[AnyObject]]()

var krakenOHLCChunks: [KrakenOHLCChunk]?
var krakenPair = "XXBTZCAD"
var krakenCandleSubset = [[AnyObject]]()
var krakenLatestOhlc = [Double]();                  var krakenPreviousOhlc = [-1.0]

var binanceCandles: [[AnyObject]]?                  //; var binanceChunks: [BinanceChunk]?
var binanceCandleSubset = [[AnyObject]]()

var shakepayPriceUpdates: [ShakepayPriceUpdate]?    //; var latestShakepayPrices: [Any]?


var latestKrakenXBTCAD = 1.0                        //; var latestBinanceETHBTCPrice = 1.0
var latestShakepayBTCCAD = 1.0
var latestBinanceETHBTC = 1.0


var historicalShakepayPrices = [Double]()

var candleGap = CGFloat(1)
var candleWidth = CGFloat(0)
var chartMarginY = CGFloat(0);                      var chartMarginX = CGFloat(0)
var chartVerticalCushion = CGFloat(0)

var lastTappedCoordinate = [-1,-1];                 var chartCoordinates = [[1,1], [1,2]]
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

//var diffAbs = 0.0;                                var diffPer = 0.0
//var diffAbsRounded = 0;                           var diffPerRounded = 0.0

//var justPinchedFromCandleView = false

//let headerTitlesWithoutIcons = ["Gold", "", "Bitcoin", "", "Shitcoins", "", "Stocks", "", "Fiat", ""]
//let headerIcons = ["💎", "", "₿", "", "💩", "", "👮🏼‍♀️", "",  "📈", ""]

