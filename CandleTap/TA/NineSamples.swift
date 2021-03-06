/*🔥CandleTap_NineSamples💧*/import UIKit

func findAndPlotNinesAndNeighbouringCandles(size: Int) {
    
    for ohlc in binanceHistorical { // refactor later so this second loop through the array is avoided, instead do all this as the array is populated
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
            if "\(nineNeighbourSample[midIndex][4])" == "9" {                               //print("there's a 9!")
                if "\(nineNeighbourSample[midIndex][5])" == "G" {chartGreenNines += 1}      //print("there's a green 9!")
                if "\(nineNeighbourSample[midIndex][5])" == "R" {chartRedNines += 1}        //print("there's a red 9!")
                ninesAndTheirNeighbours.append(nineNeighbourSample)
                nineCenteredOHLCs.append(nineNeighbourPlotSample)
            }
        }                                                                                   //; print(ohlcPlusSeq)
    }
    
    //    pryntNineCenteredOHLCs()
}

extension UIViewController {
    @objc func jumpBetweenNines(forSnapshotting: Bool) {
        
        if !initialManualIncrement && !forSnapshotting {
            nineChartIndex += 1; candleSubset = nineCenteredOHLCs[nineChartIndex]
            initialManualIncrement = true
        }                                                                                   //; print("jumping between 9s; index \(nineChartIndex)")
        
        let t = 0.5
        let delay = forSnapshotting ? DispatchTime.now() + t : DispatchTime.now() + 0
        
        if nineChartIndex <= nineCenteredOHLCs.count - 1 {
            
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.goToNextNineChart()
                
                if forSnapshotting {
                    self.jumpBetweenNines(forSnapshotting: true)
                }
            }
        } else {
            nineChartIndex = 0
            candleSubset = nineCenteredOHLCs[0]
            
            if forSnapshotting {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.gotoView(vc: pairListVC)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + t) {                       print("\n\(nineScreenshots.count) screenshots\n")
                    pairListVC.presentEmail()
                }
            } else {goToNextNineChart()}
        }
    }
    
    func goToNextNineChart() {
        
        if chartDisplayed {
            chartVC.getChart()
            snapshotView(view: chartVC.view)
        }
        
        nineChartIndex += 1
        if nineChartIndex <= nineCenteredOHLCs.count - 1 {
            candleSubset = nineCenteredOHLCs[nineChartIndex]
        }
    }
    
    func snapshotView(view: UIView) {                                                       //print("taking screenshot; chart # \(nineChartIndex)")
        let snapshot = view.snapshotView(afterScreenUpdates: false)!
        
        snapshot.translatesAutoresizingMaskIntoConstraints = false
        
        let frac = CGFloat(1)
        let testFrame = CGRect(x: 0, y: 0, width: view.frame.width / frac, height: view.frame.height / frac)
        snapshot.frame = testFrame
        
        ///pairListVC.view.addSubview(snapshot)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            let bounds = UIScreen.main.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, true, 1.0)
            view.drawHierarchy(in: bounds, afterScreenUpdates: false)
            latestNineScreenshot = UIGraphicsGetImageFromCurrentImageContext()
            nineScreenshots.append(latestNineScreenshot!)
            UIGraphicsEndImageContext()                                                     //; print("screenshot: \(nineScreenshot!)")
            
            /*let testImageView = UIImageView()
             testImageView.frame = CGRect(x: 0, y: 0, width: globalWindow.frame.width / 2, height: globalWindow.frame.height / 2)
             testImageView.image = nineScreenshot
             pairListVC.view.addSubview(testImageView)*/
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

