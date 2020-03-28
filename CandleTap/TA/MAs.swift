/*🔥CandleTap_MAs💧*/import UIKit

func updateMovingAverages(maLength: Int, plottingInterval: Int, ohlcs: [[AnyObject]]) {
    
    var maPriceArrays = ohlcs
    var closingPrices = [Double]();     var allClosingPrices = [Double]()
    var MAsToPlot = [Double]()
    
    let diff = maPriceArrays.count - maLength - plottingInterval
    maPriceArrays.removeFirst(diff >= 0 ? diff : 0)
    
    var i = 0
    for _ in (0 ... maPriceArrays.count - 1) {
        
        let close = Double("\(maPriceArrays[i][4])")!
//        if !maPrintBoolLock {print(close)} ///; print("closing price #\(i+1) for MA: \(close)")
        
        closingPrices.append(close)
        allClosingPrices.append(close)
        
        if (maLength ... maPriceArrays.count - 1).contains(i) {
            closingPrices.removeFirst()
            
            let avg = closingPrices.average
            ///MAValues.append(avg)  ///; print("moving avg. #\(i+1), length \(closingPrices.count)/\(MAValues.count) = \(avg); i = \(i)")
            MAsToPlot.append(avg)
        }
        i += 1
    }
    
    MAValues = MAsToPlot                                                //; print("\(maLength)-period moving average count:\(MAValues.count)")
    
    if !maPrintBoolLock { /**/
//        let averagesNewlined = MAValues.map {"\($0)"}.joined(separator: "\n")
//        print("\nall \(MAValues.count) \(maLength)-period moving averages:\n\(averagesNewlined)", terminator: "\n")
        
//        let closingPricesNewlined = allClosingPrices.map {"\($0)"}.joined(separator: "\n")
//        print("\nall \(allClosingPrices.count) closing prices for checking:\n\(closingPricesNewlined)", terminator: "\n")
        
        maPrintBoolLock = true
    }                                                                   //print("\n\(maLength)-period moving averages:\n\(MAValues)")
}

/// Following 3 extensions return the average of all elements in an array
extension Collection where Element: Numeric {
    var total: Element { reduce(0, +) }
}
extension Collection where Element: BinaryInteger {
    var average: Double { isEmpty ? 0 : Double(total) / Double(count) }
}
extension Collection where Element: BinaryFloatingPoint {
    var average: Element { isEmpty ? 0 : total / Element(count) }
}

/*
 //        var k = 0
 //        for ohlc in movingAvgPriceArrays {
 //            print("ohlc: \(k): \(ohlc)")
 //            k += 1
 //        }
 
 //        print("\n")
 */

