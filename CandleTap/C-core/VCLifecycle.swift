/*🔥CandleTap_VCLifecycle💧*/import UIKit

extension CollectionVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = backgroundColour
        collectionView.bounces = false
        
        setTopViewController()
        
        //let str = (showConsoleLegend) ? loadSymbolLegend : ""       ; print("💾\(viewControllerType)\(str)")// disk emoji means loaded 💾
        
        statusBarHeightChangeNotificationSetup()
        
        if ![.popupMenu].contains(viewControllerType) {setupPinchToExit()}
        
        periodicDateRefresh(){kickoffTimer()}               /// checks the date then does the timer kickoff ('starts on the 0th callback')
        ///kickoffTimer()                                                                                       // does the timer kickoff then checks the date ('starts on the 1st callback')
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setTopViewController()
        
        setNavBarTitle(customString: viewControllerType.getNavBarTitle())
        setupNavBarButtons(greyIndex: colourIndex)
        
        justPinched = false
        
        ///if !showLoadAndAppearIndicationInConsole {                                                                                               // if the below print hasn't been done already for this vc
        ///let str = (showConsoleLegend) ? appearSymbolLegend : ""; print("🏞\(topVC.viewControllerType)\(str)")  // picture-emoji means appeared 🏞
        ///showLoadAndAppearIndicationInConsole = true
        if showConsoleLegend {showConsoleLegend = false}                              /// legend only needs to be shown once
        ///}
        
        //reloadCV()
        
        //pryntTopmostVCType()
    }
}

