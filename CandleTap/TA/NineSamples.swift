/*🔥CandleTap_NineSamples💧*/import UIKit

func findAndPlotNinesAndNeighbouringCandles(size: Int) {
    
    for ohlc in binanceETHBTCHistorical { // refactor later so this second loop through the array is avoided, instead do all this as the array is populated
        let ohlcZero = ohlc[0]
        let ohlcPlusSeq = [ohlcZero[2], ohlcZero[3], ohlcZero[4], ohlcZero[5], ohlcZero[6], ohlcZero[7]] //open,high,low,close,seq,colour
        /**/
        let ohlcToPlot
            = [ohlcZero[0],                                         //0th item is the timestamp
                ohlcZero[2],ohlcZero[3],ohlcZero[4],ohlcZero[5],    //O,H,L,C
                ohlcZero[6],ohlcZero[7],                            //Sequential count & colour
                ohlcZero[11],ohlcZero[13],ohlcZero[16]]             // last 3 items are the 20, 50 & 200 MAs
        
        if nineNeighbourSample.count == size {      //for Sequential : analyzing neighbourhood of 9's
            nineNeighbourSample.removeFirst()
            nineNeighbourPlotSample.removeFirst()
        }
        
        if nineNeighbourSample.count <= size {      //"                                             "
            nineNeighbourSample.append(ohlcPlusSeq)
            nineNeighbourPlotSample.append(ohlcToPlot)
        }
        
        let midIndex = (size-1)/2
        if nineNeighbourSample.count == size {
            if "\(nineNeighbourSample[midIndex][4])" == "9" {                                  //print("there's a 9!")
                if "\(nineNeighbourSample[midIndex][5])" == "G" {chartGreenNines += 1}         //print("there's a green 9!")
                if "\(nineNeighbourSample[midIndex][5])" == "R" {chartRedNines += 1}           //print("there's a red 9!")
                ninesAndTheirNeighbours.append(nineNeighbourSample)
                nineCenteredOHLCs.append(nineNeighbourPlotSample)
            }
        }                                                                                      //; print(ohlcPlusSeq)
    }
    
//    pryntNineCenteredOHLCs()
}

extension UIViewController {
    @objc func jumpBetweenNines() {
        
        if nineChartIndex < nineCenteredOHLCs.count - 1 {
            nineChartIndex += 1
        } else {nineChartIndex = 0}
        
        candleSubset = nineCenteredOHLCs[nineChartIndex]            //; print("\nTAP (index \(nineChartIndex))")
        
        if chartDisplayed {
            chartVC.getChart()
        }
    }
}

func pryntNineCenteredOHLCs() {
    
//    print("\nok there are \(ninesAndTheirNeighbours.count) nines and their neighbours")
    
//    let historicalOHLCs = ninesAndTheirNeighbours[0] //index 0 only, is just for printing single ohlc array sample one at a time
//    let newlinedNinesAndNeighbourhood = historicalOHLCs.map {"\($0)"}.joined(separator: "\n")
//    print("first nine with \((historicalOHLCs.count-1)/2) candles on either side:\n\n\(newlinedNinesAndNeighbourhood)")

    let historicalOHLCDoubles = nineCenteredOHLCs[6] //index 0 only, is just for printing single ohlc array sample one at a time
    let doubleNewlinedNinesAndMAs = historicalOHLCDoubles.map {"\($0)"}.joined(separator: "\n")
    print("\nfirst nine with \((historicalOHLCDoubles.count-1)/2) candles on either side:\n\n\(doubleNewlinedNinesAndMAs)")
}

/*
 //        let ohlcToPlot
 //            = [Double("\(ohlcZero[0])")!,                                                                   //0th item is the timestamp
 //                Double("\(ohlcZero[2])")!, Double("\(ohlcZero[3])")!, Double("\(ohlcZero[4])")!, Double("\(ohlcZero[5])")!, //O,H,L,C
 //                Double("\(ohlcZero[6])")!,                                                                  //Sequential count (an Int; truncate)
 //                Double("\(ohlcZero[11])")!, Double("\(ohlcZero[13])")!, Double("\(ohlcZero[16])")!]         // last 3 items are the 20, 50 & 200 MAs
 */

