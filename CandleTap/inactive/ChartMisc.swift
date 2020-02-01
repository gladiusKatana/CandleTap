/*🔥CandleTap_ChartMisc💧*/import UIKit


//func plotCandles(priceData: [[AnyObject]], chartViewHeight: CGFloat, chartViewWidth: CGFloat, scalor: Double, absLow: Double) {
//
//    ///var printedCandleEmoticon = false
//    for i in 0 ... priceData.count - 1 {                        ///print("#\(i+1)")
//
//        let open = Double("\(priceData[i][1])")!                /// 3, for the 'pretend there's no wick + green only' test //***
//        let high = Double("\(priceData[i][2])")!
//        let low = Double("\(priceData[i][3])")!
//        let close = Double("\(priceData[i][4])")!               /// 2, for the 'pretend there's no wick + green only' test
//
//        displayCandleAndWick(open: open, high: high, low: low, close: close, scalor: scalor, absLow: absLow, candleIndex: i, latestCandleOnly: false)
//        //print("🕯\(i)", terminator: ""); if !printedCandleEmoticon {printedCandleEmoticon = true}
//    }
//}


//var binanceCandleSample = binance Candles!.suffix(200) //as! [[AnyObject]] //https://developer.apple.com/documentation/swift/arrayslice

//extension ChartVC {
//
//
//}


//func plotLatestCandle(priceData: [[AnyObject]], chartViewHeight: CGFloat, chartViewWidth: CGFloat, scalor: Double, absLow: Double) {
//
//    let i = priceData.count - 1
//
//    let open = Double("\(priceData[i][1])")!                    /// 3, for the 'pretend there's no wick + green only' test //***
//    let high = Double("\(priceData[i][2])")!
//    let low = Double("\(priceData[i][3])")!
//    let close = Double("\(priceData[i][4])")!                   /// 2, for the 'pretend there's no wick + green only' test
//
//    displayCandleAndWick(open: open, high: high, low: low, close: close, scalor: scalor, absLow: absLow, candleIndex: i,
//                         latestCandleOnly: true)
//    //print("🕯plotting latest candle only🕯")
//}


/*extension ChartVC {
    
    func plotLine() {
        
        let maLine = LineView(frame: chartFrame)
        
        self.view.addSubview(maLine)
    }
    
}*/


/*class LineView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear//defaultGreyoutColour
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        let line = UIBezierPath()
        line.move(to: CGPoint(x: maXcoord1, y: maYcoord1))
        line.addLine(to: CGPoint(x: maXcoord2, y: maYcoord2))
        line.lineWidth = 2
        line.stroke()

//        UIColor(red: 163/255, green: 189/255, blue: 218/255, alpha: 1).setFill()
//
//        let origins = [CGPoint(x: 10, y: 1),
//                       CGPoint(x: 50, y: 1),
//                       CGPoint(x: 90, y: 1)]
//
//        let size = CGSize(width: 8, height: 8)
//
//        for origin in origins {
//            let quad = UIBezierPath.init(roundedRect: CGRect(origin: origin, size: size), cornerRadius: 2)
//            quad.fill()
//            quad.stroke()
//        }
    }
    
//    override func draw(_ rect: CGRect) {
//        if let context = UIGraphicsGetCurrentContext() {
//            context.setStrokeColor(UIColor.blue.cgColor)
//            context.setLineWidth(2)
//            context.beginPath()
//            context.move(to: CGPoint(x: maXcoord1, y: maYcoord1)) // This would be oldX, oldY
//            context.addLine(to: CGPoint(x: maXcoord2, y: maYcoord2)) // This would be newX, newY
//            context.strokePath()
//        }
//        else {print("could not initialize context")}
//    }
}*/


/*pinchToClose = UIPinchGestureRecognizer(target: self, action: #selector(closeChart))
 chartView.addGestureRecognizer(pinchToClose)*/

//    @objc func closeChart() {
//        if pinchToClose.velocity > 0 {
//            if !justPinchedFromCandleView {                                         //print("pinched out from candle view")
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    self.dismissCandleView()
//                }
//                justPinchedFromCandleView = true
//            }
//        }
//    }
//
//    @objc func dismissCandleView() {
//        //chartView.removeGestureRecognizer(pinchToClose)
//        chartView.removeFromSuperview() /////candleVC.view.removeFromSuperview()
//        DispatchQueue.main.asyncAfter(deadline: .now()) {
//            self.gotoView(vc: pairListVC)
//        }
//        justPinchedFromCandleView = false
//    }

///print(" Open time         Open         High       Low        Close        Volume      Close time       QAV   #Trades   TBAV        TQAV    (ignore)")

//print("(\n\n\(binanceCandleSubset.count) samples, \(highs.count) highs & \(lows.count) lows, sampled from 500\n")




//         0            1           2          3           4            5             6             7         8          9
// [1543971120000, 0.02782500, 0.02783700, 0.02782500, 0.02782900, 16.44100000, 1543971179999, 0.45753156,    16,    8.71800000,  0.24263196, 0]
//      10     11
//     Open time      Open         High       Low        Close        Volume      Close time       QAV      #Trades     TBAV
//     TQAV    ignore

//                                                                  QAV = Quote Asset Volume;   TBAV = Taker buy BASE Asset Volume;
//                                                                                              TQAV = Taker buy QUOTE Asset Volume

//    override func viewDidDisappear(_ animated: Bool) {  print("\n                            🕯d")
//    }

//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        if UIDevice.current.orientation.isLandscape { print("landscape chart")
//            chartOrientation = "landscape"
//        } else {                                      print("portrait chart")
//            chartOrientation = "portrait"
//        }
//
//        if chartOrientation != previousChartOrientation {
//            dismissChartAndCandles()
//            gotoView(vc: candleVC)
//            chartOrientation = previousChartOrientation
//        }
//    }
