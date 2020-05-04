/*🔥CandleTap_NineSamples💧*/import UIKit

func findAndPlotNinesAndNeighbouringCandles(size: Int) {
    for ohlc in binanceETHBTCHistorical {
        let ohlcZero = ohlc[0]
        let ohlcPlusSeq = [ohlcZero[2],ohlcZero[3],ohlcZero[4],ohlcZero[5],ohlcZero[6],ohlcZero[7]] //open,high,low,close,seq,colour
        
        if nineNeighbourSample.count == size { nineNeighbourSample.removeFirst() }       //for Sequential : analyzing neighbourhood of 9's
        if nineNeighbourSample.count <= size { nineNeighbourSample.append(ohlcPlusSeq) } //"                                             "
        
        let midIndex = (size-1)/2
        if nineNeighbourSample.count == size {
            if "\(nineNeighbourSample[midIndex][4])" == "9" {                                  //print("there's a 9!")
                if "\(nineNeighbourSample[midIndex][5])" == "G" {chartGreenNines += 1}         //print("there's a green 9!")
                if "\(nineNeighbourSample[midIndex][5])" == "R" {chartRedNines += 1}           //print("there's a red 9!")
                ninesAndTheirNeighbours.append(nineNeighbourSample)
            }
        }                                                                                //; print(ohlcPlusSeq)
    }
    
    //                print("ok there are \(ninesAndTheirNeighbours.count) nines and their neighbours")
    let index = 0 //just for printing single ohlc array sample one at a time
    let newlinedNinesAndNeighbourhood = ninesAndTheirNeighbours[index].map {"\($0)"}.joined(separator: "\n")
    print("first nine with \((ninesAndTheirNeighbours[index].count-1)/2) candles on either side:\n\n\(newlinedNinesAndNeighbourhood)")
}

