///*🔥CandleTap_PlotMA💧*/import UIKit

//var maPoint = Bar(frame: zeroFrame)

//
//extension ChartVC {
//    
//    func plotMovingAverage(priceData: [Double], scalor: Double, absLow: Double) {
//        
//        let lineWidth = CGFloat(4)
//        
//        var j = 0
//        
//        for i in 0 ... priceData.count - 1 {                                        //print("price data for MA: \(priceData)")
//            
//            let closeOne = priceData[i/*-1*/]
////            let closeTwo = priceData[i]
//            
//            let margin = Double(chartMargin)
//            let chartBottom = margin + Double(chartViewHeight)
//            
//            let maPriceOne = scalor * (closeOne - absLow)                           //; print("1st price for MA: \(maPriceOne)")
////            let maPriceTwo = scalor * (closeTwo - absLow)                           //; print("2nd price for MA: \(maPriceTwo)")
//            
//            let maY1 = chartBottom - maPriceOne    // Y1
////            let maY2 = chartBottom - maPriceTwo    // Y2
//            
//            
//            let halfWidthMinusGap = 0.5 * Double(candleWidth - candleGap)
//            let candleWid = Double(candleWidth)
//            
//            let maX1 = margin + halfWidthMinusGap + candleWid * Double(i)         // X1
////            let maX2 = margin + halfWidthMinusGap + candleWid * Double(i)           // X2
//            
//            
//            let maPointFrame = CGRect(x: CGFloat(maX1),
//                                      y: CGFloat(maY1),
//                                      width: lineWidth,
//                                      height: lineWidth)
//            
//
//            
//            
//            maPoint = Bar(frame: maPointFrame)       ; maPoint.backgroundColor = .purple
//            
//            self.view.addSubview(maPoint)
//            
//            
//            
//            j += 1
//            
//            
//            
//            
//            /*
//             
//             
//             
//             y = chartViewHeight - chartMargin - CGFloat(scalor * maPriceOne)
//             
//             
//             
//             */
//            
//            
//            
//            
//            
//            
//            
//            //            maXcoord1 = 10.0; maXcoord2 = 30.0
//            //            maYcoord1 = 10.0; maYcoord2 = 10.0
//            
//            //            maXcoord1 = 5 * Double(i-1) ; maYcoord1 = 5 * Double(i-1)
//            //            maXcoord2 = 5 * Double(i)   ; maYcoord2 = 5 * Double(i)
//            
//            //print("plotting @ (\(maXcoord1),\(maYcoord1))")
//            
//            //            plotLineAsLayer()
//        }
//    }
//}
//
//
////func plotLineAsLayer() {
////
//////    NSColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
////
////    let lineLayer = CAShapeLayer()
//////    lineLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: statusBarHeight + navBarHeight,
//////                                                               width: 4, height: 4), cornerRadius: 0).cgPath
////
////    let line = UIBezierPath()
////    line.move(to: CGPoint(x: 10, y: 5))
////    line.move(to: CGPoint(x: 90, y: 5))
////    line.lineWidth = 2
//////    line.stroke()
////
////    lineLayer.path = line as! CGPath
////
////    ///let randNum = randomNumber(inRange: 1...7) - 1
////    lineLayer.fillColor = UIColor.green.cgColor///randomColours[randNum]
////
////    globalWindow.layer.addSublayer(lineLayer)
////}
//
//
//
//
//
/////included for reference for plotting lines:
///*let wickWidth = CGFloat(0.5)
// let wickX = chartMargin + 0.5 * (candleWidth - candleGap - wickWidth) + candleWidth * CGFloat(i)*/
//
//

