/*🔥CandleTap_TradingVars💧*/import UIKit



let apiServ = ApiService()

var exchangeID = ExchangeID.binance




var krakenApiResponses: [KrakenApiResponse]?

var krakenPair = "XXBTZUSD"//"XXBTZCAD"  /// hardcoded for now




var shakepayApiResponses: [ShakepayApiResponse]?    //; var latestShakepayPrices: [Any]?

var historicalShakepayPrices = [Double]()




var binanceCandleSubset = [[AnyObject]]()

var globalBinanceCandles = [[AnyObject]]()




var latestKrakenXBTZCAD = 1.0                       //; var latestBinanceETHBTCPrice = 1.0
var latestShakepayBTCCAD = 1.0
var latestBinanceETHBTC = 1.0


