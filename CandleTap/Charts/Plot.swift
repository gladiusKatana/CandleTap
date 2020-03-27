/*🔥CandleTap_Plot💧*/import UIKit

extension ChartVC {
    
    func plotCandlesAndIndicators(open: Double, high: Double, low: Double, close: Double, scalor: Double, absLow: Double,
                                  candleIndex index: Int, MA: Double) {
        
        var candleColour = UIColor()                        ; let lineWidth = CGFloat(0.5)  ; let wickColour = UIColor.white
        if close < open {candleColour = .red}
        else if close == open {candleColour = .yellow}      ///; print("close = open at candle \(i)")}
        else {candleColour = jadeGreen}                     ; let MAPointSize = 2.0; let halfPointSize = MAPointSize / 2
        
        let margin = -Double(chartMarginY)
        let candleCenterX = chartMarginX + 0.5 * (candleWidth - candleGap - lineWidth) + candleWidth * CGFloat(index)
        
        // --------------------------------------------------------------- CANDLES ------------------------------------------------------------
        let candleHeight = scalor * abs(close - open)                               /// next 6 lines: // 'Top' is measured from bottom... also:
        let candleTop = margin + scalor * abs(max(open, close) - absLow)            /// abs() prob. not needed, this line & below;...
        
        let lowerWickHeight = scalor * abs(min(open, close) - low)                  /// ...& 'abs' in  abs-Low  =  *absolute* low; absHigh: ditto
        let lowerWickTop = margin + scalor * abs(min(open, close) - absLow)
        
        let upperWickHeight = scalor * abs(high - max(open, close))
        let upperWickTop = margin + scalor * abs(high - absLow)
        
        let candleRect = CGRect(x: chartMarginX + candleWidth * CGFloat(index),
                                y: chartViewHeight - CGFloat(candleTop) - chartVerticalCushion,
                                width: candleWidth - candleGap,
                                height: CGFloat(candleHeight))
        
        let upperWickRect = CGRect(x: candleCenterX,
                                   y: chartViewHeight - CGFloat(upperWickTop) - chartVerticalCushion,
                                   width: lineWidth,
                                   height: CGFloat(upperWickHeight))
        
        let lowerWickRect = CGRect(x: candleCenterX,
                                   y: chartViewHeight - CGFloat(lowerWickTop) - chartVerticalCushion,
                                   width: lineWidth,
                                   height: CGFloat(lowerWickHeight))
        
        candle = Bar(frame: candleRect);          candle.backgroundColor = candleColour
        self.view.addSubview(candle)
        
        topWick = Bar(frame: upperWickRect);      topWick.backgroundColor = wickColour
        self.view.addSubview(topWick)
        
        bottomWick = Bar(frame: lowerWickRect);   bottomWick.backgroundColor = wickColour
        self.view.addSubview(bottomWick)
        
        // --------------------------------------------------------------------------------- MA points --------------------
        let MAPointYScaled = scalor * (MA - absLow)
        let MAPointHeight = margin + halfPointSize + MAPointYScaled

        let y = chartViewHeight - CGFloat(MAPointHeight) - chartVerticalCushion; let x = candleCenterX

        let MAPointRect = CGRect(x: x - CGFloat(halfPointSize),
                                 y: y,
                                 width: CGFloat(MAPointSize),
                                 height: CGFloat(MAPointSize))

        let MAPoint = Bar(frame: MAPointRect);   MAPoint.backgroundColor = .purple
        self.view.addSubview(MAPoint)
        
        if index > 0 { // ------------------------------------------------------------------- MA lines --------------------
            let deltaX = Double(x - previousX)  ; let deltaY = Double(y - previousY)
            let hypotenuse = sqrt(square(deltaY) + square(deltaX))
            let angle = CGFloat.pi / 2 + CGFloat(atan(deltaY / deltaX)) ///in radians
            let midX = 0.5 * (x + previousX)    ; let midY = 0.5 * (y + previousY)

            let lineFrame = CGRect(x: CGFloat(midX),
                                   y: CGFloat(midY) - 0.5 * CGFloat(hypotenuse) + CGFloat(halfPointSize),
                                   width: lineWidth * 2,
                                   height: CGFloat(hypotenuse))

            let maLineSegment = Bar(frame: lineFrame)       ; maLineSegment.backgroundColor = .purple

            maLineSegment.transform = CGAffineTransform(rotationAngle: angle)
            //maLineSegment.transform = CGAffineTransform.identity

            self.view.addSubview(maLineSegment)

            previousX = x; previousY = y
        }
        else {previousX = x; previousY = y}
    }
}

func square(_ x: Double) -> Double {
    return x * x
}

