/*🔥CandleTap_GetChart💧*/import UIKit

extension ChartVC {
    
    func getChart() {                                                               ///print("showing candles")
        
        var highs = [Double]();  var lows = [Double]()              ///var lowerWickRanges = [Double]();   var upperWickRanges = [Double]()
        var MAs = [Double]()
        
        var i = 0
        for arr in candleSubset {                                                     //print("appending highs & lows")
            highs.append(Double("\(arr[2])")!)
            lows.append(Double("\(arr[3])")!)
//            MAs.append(MAValues[i])                                                 ///; print("appending \(MAValues[i])")
            i += 1
        }
        
        if let absLow = lows.min(), let absHigh = highs.max()/*, let maxMA = MAs.max(), let minMA = MAs.min()*/ {
            
            var absMin = absLow
            var absMax = absHigh
            
//            if maxMA > absHigh {absMax = maxMA}; if minMA < absLow {absMin = minMA}
            
//            if let maxMA = MAs.max(), let minMA = MAs.min() {
//                if maxMA > absHigh {absMax = maxMA}; if minMA < absLow {absMin = minMA} ///; print("local max = \(absMax)")
//            } else {print("could not get MA max and min")}
            
            let range = absMax - absMin                                             ///; print("range: \(range)\n")
            let scaledRange = Double(chartViewHeight - 2 * chartVerticalCushion)    ///print("\nscaled range: \(scaledRange)\n")
            let scalor = scaledRange / range
            
            self.view.subviews.forEach({ $0.removeFromSuperview() })
            
            for i in 0 ... candleSubset.count - 1 {                                 ///print("#\(i+1)")//🕯
                
                let open = Double("\(candleSubset[i][1])")!                         /// 3, for 'pretend there's no wick + green only' test //***
                let high = Double("\(candleSubset[i][2])")!
                let low = Double("\(candleSubset[i][3])")!
                let close = Double("\(candleSubset[i][4])")!                        /// 2, for the 'pretend there's no wick + green only' test
                let MA = 0.0//MAValues[i]
                
                plotCandlesAndIndicators(open: open, high: high, low: low, close: close, scalor: scalor, absLow: absLow, candleIndex: i,
                                         MA: MA)
                
                let ohlcString = "[\(open), \(high), \(low), \(close)]"
//                print("OHLC: \(ohlcString)")
            }
            
//            print("\n")
            
            let currentClose = Double("\(candleSubset[candleSubset.count - 1][4])")!
            plotChartAxes(range: range, absLow: absLow, currentClose: currentClose) ///plotMovingAverage(priceData: MAValues, scalor: scalor,...
            
            plotLine(y: chartMarginY + chartVerticalCushion)
            
        } else {print("max and min if-let for chart failed")}
    }
    
    func plotChartAxes(range: Double, absLow: Double, currentClose: Double) {
        chartBorder = PlotRectange(frame: chartFrame)
        chartBorder.draw(CGRect(x: chartMarginY, y: 0, width: 10, height: 10))
        self.view.addSubview(chartBorder)
        
        let minY = CGFloat(frameHeight) - chartMarginY - chartVerticalCushion

        let rangeIncrement = range / 10.0;    let coordIncrement = (minY - chartMarginY) / 10.0
        
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

