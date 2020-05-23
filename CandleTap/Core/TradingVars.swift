/*🔥CandleTap_TradingVars💧*/import UIKit



let apiServ = ApiService()
var exchangeID = ExchangeID.binance



var krakenApiResponses: [KrakenApiResponse]?
var krakenPair = "XXBTZUSD"//"XXBTZCAD"  /// hardcoded for now



var shakepayApiResponses: [ShakepayApiResponse]?    //; var latestShakepayPrices: [Any]?
var historicalShakepayPrices = [Double]()



var binanceLatestPrice: [BinanceLatestPrice]?
var globalBinanceCandles = [[AnyObject]]()
//var binanceCandleSubset = [[AnyObject]]()
//var historicalBinanceCandles = [[AnyObject]]()



var historicalBatch = 0 //batch counter
var lastHistoricalTimestamp = Int64(0)

var globalKrakenTimestamp = Int64(0.0) // Double(0) // 1589397166639428781 is a recent month start timestamp for Kraken (written May 13, 2020)

var latestKrakenXBTZCAD = 1.0
var latestShakepayBTCCAD = 1.0
var latestBinanceETHBTC = 1.0


var nineNeighbourSample = [[AnyObject]]();          var ninesAndTheirNeighbours = [[[AnyObject]]]() //for Sequential🟥🟩
var nineNeighbourPlotSample = [[AnyObject]]();      var nineCenteredOHLCs = [[[AnyObject]]]()
//var nineNeighbourPlotSample = [[Double]]();         var nineCenteredOHLCs = [[[Double]]]()

var greens = 0;             var reds = 0
var greenNines = 0;         var redNines = 0
var chartGreenNines = 0;    var chartRedNines = 0
var nineChartIndex = 0

