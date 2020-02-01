/*🔥CandleTap_ChartLifecycle💧*/import UIKit

extension ChartVC {
    
    override func viewDidLoad() {                           super.viewDidLoad()                 //; print("\n💾chart")
        ///setTopViewController()
        chartMarginY = CGFloat(navBarHeight)
        chartMarginX = CGFloat(navBarHeight) * 1.7
        chartVerticalCushion = CGFloat(15) /// appears on top & bottom
        
        let wid = CGFloat(globalWindow.frame.width - chartMarginX * 2)
        let hei = CGFloat(globalWindow.frame.height - chartMarginY * 2)
        
        candleWidth = (wid - candleGap) / CGFloat(candleSubset.count) // incl. (non-leftmost) gap (?)
        
        chartFrame = CGRect(x: chartMarginX, y: chartMarginY, width: wid, height: hei)    /// (inherits & has all properties of UIView)
        
        chartViewWidth = wid
        
        chartViewHeight = hei ///= CGFloat(frameWidth); chartViewHeight = CGFloat(frameHeight)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {        super.viewWillAppear(animated)
        setNavBarTitle(customString: viewControllerType.getNavBarTitle())
        setupNavBarButtons(greyIndex: 1)
        setupPinchToExit()
        
        justPinched = false
        chartDisplayed = true
        
        getChart()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {     super.viewWillDisappear(animated)
        chartDisplayed = false
    }
}

