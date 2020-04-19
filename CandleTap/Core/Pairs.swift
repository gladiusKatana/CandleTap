/*🔥CandleTap_Pairs💧*/import Foundation

var tickerPairs = ["BTCCAD",
                   "XBTCAD",
                   "ETHBTC",
                   "XRPBTC",
                   "BCHBTC",
                   "LTCBTC",
                   "BSVBTC",
                   "EOSBTC"]/*,
                   "BNBBTC",
                   "XMRBTC",
                   "TRXBTC",
                   "ADABTC",
                   "XLMBTC",
                   "XTZBTC"]*/

var currentPrices = [latestShakepayBTCCAD, latestKrakenXBTZCAD, latestBinanceETHBTC]
                
var binanceETHBTCHistorical = [[[Double]](), [[Double]](), [[Double]](), [[Double]](), [[Double]](), [[Double]]()]// W, D, 4h, h, 30m, 15m
