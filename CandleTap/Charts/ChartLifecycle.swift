/*🔥CandleTap_ChartLifecycle💧*/import UIKit

extension ChartVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()                                 ; print("\n💾chart")
        ///setTopViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBarTitle(customString: "there's a 9! (\((candlesToPlot-1)/2+1)th candle)")
        //setNavBarTitle(customString: viewControllerType.getNavBarTitle())
        setupNavBarButtons(greyIndex: 1)
        
        setupPinchToExit()
        setupTapToJumpBetweenNines()
        
        justPinched = false
        
        chartMarginY = CGFloat(navBarHeight)
        chartMarginX = CGFloat(navBarHeight) * 1.7
        chartVerticalCushion = CGFloat(15) /// appears on top & bottom
        
        let wid = CGFloat(globalWindow.frame.width - chartMarginX * 2)
        let hei = CGFloat(globalWindow.frame.height - chartMarginY * 2)
        
        candleWidth = (wid - candleGap) / CGFloat(candlesToPlot) // incl. (non-leftmost) gap (?)
        chartFrame = CGRect(x: chartMarginX, y: chartMarginY, width: wid, height: hei)    /// (inherits & has all properties of UIView)
        
        chartViewWidth = wid
        chartViewHeight = hei ///= CGFloat(frameWidth); chartViewHeight = CGFloat(frameHeight)
        
        getChart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        chartDisplayed = true
        
        ///self.periodicDateRefresh(){self.kickoffTimer()}
        
        //apiServ.getFeeds(toPlot: exchangeID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        ///self.view.subviews.forEach({ $0.removeFromSuperview() })
        
        chartDisplayed = false
    }
}

