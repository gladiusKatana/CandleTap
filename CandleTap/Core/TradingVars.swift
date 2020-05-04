/*🔥CandleTap_TradingVars💧*/import UIKit



let apiServ = ApiService()

var exchangeID = ExchangeID.binance




var krakenApiResponses: [KrakenApiResponse]?

var krakenPair = "XXBTZUSD"//"XXBTZCAD"  /// hardcoded for now




var shakepayApiResponses: [ShakepayApiResponse]?    //; var latestShakepayPrices: [Any]?

var historicalShakepayPrices = [Double]()




var binanceCandleSubset = [[AnyObject]]()

var globalBinanceCandles = [[AnyObject]]()
var historicalBinanceCandles = [[AnyObject]]()

var binanceLatestPrice: [BinanceLatestPrice]?



var historicalBatch = 0 //batch counter
var lastHistoricalTimestamp = Int64(0)

var latestKrakenXBTZCAD = 1.0                       //; var latestBinanceETHBTCPrice = 1.0
var latestShakepayBTCCAD = 1.0
var latestBinanceETHBTC = 1.0


var greens = 0;             var reds = 0

var greenNines = 0;         var redNines = 0
var chartGreenNines = 0;    var chartRedNines = 0

var previousTDColour = ""
