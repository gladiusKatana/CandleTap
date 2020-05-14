/*🔥CandleTap_AppDelegate💧*/import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var orientationLock = UIInterfaceOrientationMask.all       /// set orientations you want allowed by default
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        frameHeight = Double(globalWindow.frame.height)
        frameWidth = Double(globalWindow.frame.width)
        
        setColoursFromSettings()
        
        apiServ.getFeeds(toPlot: exchangeID)   // only needs to be called at this stage, before selecting a chart to plot, for *current* prices
        
        //fetchBinanceHistoricalOHLCs(ticker: "LTC", interval: .week, startTime: 0) //ETHBTC
        
        ///krakenBatchedApiCall()
        
        krakenBatchedApiCall(startTime: globalKrakenTimestamp) { historicalBatchCallback() }
        
        modelName = UIDevice.modelName
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = cellDefaultColour
        window?.makeKeyAndVisible()
        globalWindow = window!
        
        AppUtility.lockOrientation(.landscape)
        
        backgroundVC = UIViewController()
        backgroundVC.view.backgroundColor = cellDefaultColour   // must match window's background colour to be invisible when rotating landscape->portrait
        backgroundVC.view.frame = globalWindow.frame
        
        getOrientationAtLaunch()                                //; print("launching on \(modelName) in \(launchOrientation) orientation")
        
        if statusBarUIView!.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBarUIView!.backgroundColor = .clear
        }
        
        UINavigationBar.appearance().barTintColor = defaultColour
        UINavigationBar.appearance().shadowImage = UIImage()
        
        //print(formattedDateString(Date(), roundedDown: false, prefix: "                      on", suffix: "", short: false))
        return true
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        navController = UINavigationController(rootViewController: backgroundVC) /// temporary, unseen initial root view controller
        window?.rootViewController = navController                  //; print("VCs*: \(String(describing: nav Controller?.viewControllers))")
        
        pairListVC.setupAndPresent(vc: pairListVC) //pairListVC.gotoView(vc: pairListVC)
        pairListVC.setTopViewController()
        return true
    }
    
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482458385
            if let statusBar = globalWindow.viewWithTag(tag) {
                return statusBar
            } else {
                ///let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)   // deprecated
                let statusBarView = UIView(frame: (globalWindow.windowScene?.statusBarManager!.statusBarFrame)!)
                statusBarView.tag = tag
                globalWindow.addSubview(statusBarView)
                return statusBarView
            }
        } else if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        } else {return nil}
    }
}


//func krakenBatchedApiCall() {
//
//    DispatchQueue.global(qos: .userInitiated).asyncAfter(   ///DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
//    deadline: .now()) { //[weak self] in
//
//        apiServ.getKrakenHistoricalFeed(ticker: "xbtusd", interval: .week, startTime: 0) { responses in
//            krakenApiResponses = responses
//        }
//    }
//}


func krakenBatchedApiCall(startTime: Int64, completion: @escaping/**/ () -> ()) {          print("start time: \(startTime)")
    
    apiServ.getKrakenHistoricalFeed(ticker: "xbtcad", interval: .month, startTime: globalKrakenTimestamp) { responses in
        
        //krakenApiResponses = responses
        
        guard let krakenBtcPrices = responses[0].result?.XXBTZCAD else {print(".last failed"); return}
        
        guard let last =            responses[0].result?.last else {print("ticker failed"); return}
        
        guard let lastItem = krakenBtcPrices.last else {print("there is no last"); return}
        
        let lastTimestamp = Double("\(lastItem[2])")                                        ; print("> hist. batch \(historicalBatch)")
        
        let lastPrice = Double("\(krakenBtcPrices.last![0])")!                              ; print("> last price \(lastPrice)")
        globalKrakenTimestamp = Int64("\(last)")!/*lastTimestamp*/                           ; print("end time  : \(globalKrakenTimestamp)")
        
        //completion()
        
        if lastTimestamp != Double(lastHistoricalTimestamp) {               //print("> hist. batch \(historicalBatch) ending at \(lastTimestamp)")
            
            historicalBatch += 1                                            //; print("----------------------------------------------------------")
            ///fetchBinanceHistoricalOHLCs(ticker: ticker, interval: interval, startTime: lastTimestamp/* + 86400*/)
            lastHistoricalTimestamp = Int64(lastTimestamp!)
            completion()
            
        } else { print("ok done pulling historical data") }
        
        //completion()
    }
    
    //completion()/**/
}


func historicalBatchCallback() { print("------------------")
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {   // time delay needed due to API call rate limit (see https://www.kraken.com/features/api)
        krakenBatchedApiCall(startTime: globalKrakenTimestamp){historicalBatchCallback()}
    }
}


/*
 if let krakenBtcPrices = responses[0].result?.XXBTZUSD { //.result?.XXBTZCAD {
 ///latestKrakenXBTZCAD = Double("\(krakenBtcPrices.last![0])")!   ; print("kraken price: \(latestKrakenXBTZCAD)")
 
 let lastTimestamp = Double("\(krakenBtcPrices.last![0])")! ; print("> hist. batch \(historicalBatch) ending at \(lastTimestamp)")
 
 //    if lastTimestamp != lastHistoricalTimestamp {
 //
 //        historicalBatch += 1                                            //; print("----------------------------------------------------------")
 //        fetchBinanceHistoricalOHLCs(ticker: ticker, interval: interval, startTime: lastTimestamp/* + 86400*/)
 //        lastHistoricalTimestamp = lastTimestamp
 //
 //    } else {                                                            //print("ok done pulling historical data")
 
 } else {print("no result from Kraken historical API call")}
 */

