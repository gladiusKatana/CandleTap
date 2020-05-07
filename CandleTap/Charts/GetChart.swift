/*🔥CandleTap_GetChart💧*/import UIKit

extension ChartVC {
    
    func getChart() {                                                               //print("getting chart")
        
        var highs = [Double]();  var lows = [Double]()                              ///; var lowerWickRanges = [Double]()
//        var MAs = [Double]()                                                        ///; var upperWickRanges = [Double]()
        
        let candleCount = candleSubset.count                                        //; print("candle count: \(candleCount)")
        //; print("appending MA from \(MAValues.count) MAs, to \(MAs.count) values")
        
        for i in candleCount + 1 - candlesToPlot ..< candleCount {
            let arr = candleSubset[i]
            highs.append(Double("\(arr[2])")!)
            lows.append(Double("\(arr[3])")!)
            
//            let j = i - candleCount + 1 + candlesToPlot                                 //; print("j=\(j)")
//            MAs.append(MAValues[j])                                                 ///; print("appending \(MAValues[i])")
        }
        
        if let absLow = lows.min(), let absHigh = highs.max() {
            
            let absMin = absLow  ;  let absMax = absHigh
            
//            if let maxMA = MAs.max(), let minMA = MAs.min() {
//                if maxMA > absHigh {absMax = maxMA}; if minMA < absLow {absMin = minMA} ///; print("local max = \(absMax)")
//            } else {print("could not get MA max and min")}
            
            let range = absMax - absMin                                             ///; print("range: \(range)\n")
            let scaledRange = Double(chartViewHeight - 2 * chartVerticalCushion)    ///print("\nscaled range: \(scaledRange)\n")
            let scalor = scaledRange / range
            
            self.view.subviews.forEach({ $0.removeFromSuperview() })                //; print("will plot (O,H,L,C) \(candlesToPlot) times")
            
            for i in candleCount + 1 - candlesToPlot ..< candleCount {
                
                let open = Double("\(candleSubset[i][1])")!                         /// 3, for 'pretend there's no wick + green only' test //***
                let high = Double("\(candleSubset[i][2])")!
                let low = Double("\(candleSubset[i][3])")!
                let close = Double("\(candleSubset[i][4])")!                        /// 2, for the 'pretend there's no wick + green only' test
                
                let j = i - candleCount + candlesToPlot                             //; print("j=\(j)")
//                let MA = MAValues[j]
                let MA = 0.0
                
                let sequential = Int("\(candleSubset[i][5])")! ; let colour = "\(candleSubset[i][6])"
                
                plotCandlesAndIndicators(open: open, high: high, low: low, close: close, scalor: scalor, absLow: absLow, candleIndex: j,
                                         MA: MA, sequential: sequential, colour: colour)
                //let ohlcString = "[\(open), \(high), \(low), \(close)]"           ; print("OHLC: \(ohlcString)")
            }                                                                       //print("\n")
            
            let currentClose = Double("\(candleSubset[candleSubset.count - 1][4])")!
            plotChartAxes(range: range, absLow: absLow, currentClose: currentClose) ///plotMovingAverage(MAValues, scalor: scalor,...
//            let localYMax = chartMarginY + chartVerticalCushion
//            plotLine(y: localYMax)
            
        } else {print("max and min if-let for chart failed")}
    }
    
    func plotChartAxes(range: Double, absLow: Double, currentClose: Double) {
        chartBorder = ChartRectangle(frame: chartFrame)
        chartBorder.draw(CGRect(x: chartMarginY, y: 0, width: 10, height: 10))
        self.view.addSubview(chartBorder)
        
        let minY = CGFloat(frameHeight) - chartMarginY - chartVerticalCushion
        
        let rangeIncrement = range / 10.0;    let coordIncrement = (minY - chartMarginY) / 10.0 //; print("y-scale increments: \(coordIncrement)")
        
        for n in (0 ... 9) {
            let value = absLow + Double(n) * rangeIncrement
            let yCoordinate = minY - CGFloat(n) * coordIncrement
            showYValues(text: "\(value)", y: yCoordinate)
        }
    }
    
    func showYValues(text: String, y: CGFloat) {
        let height = CGFloat(13); let width = chartMarginX - 3
        let textField = UITextField()
        
        textField.frame = CGRect(x: CGFloat(frameWidth) - width, y: y - height / 2,
                                 width: width, height: height)
        
        textField.backgroundColor = .clear//darkGray
        textField.textColor = .white
        textField.text = text
        textField.font = UIFont.systemFont(ofSize: 10, weight: .ultraLight) /// UIFont(name: "Helvetica Neue", size: 12)
        
        self.view.addSubview(textField)
        
        plotLine(y: y)
    }
    
    func plotLine(y: CGFloat) {
        let yLineFrame = CGRect(x: chartMarginX,
                                y: y,
                                width: CGFloat(frameWidth) - chartMarginX * 2,
                                height: CGFloat(0.5))
        
        let yLine = Bar(frame: yLineFrame);   yLine.backgroundColor = platinumLite
        self.view.addSubview(yLine)
    }
}

