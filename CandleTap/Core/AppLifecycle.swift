/*🔥CandleTap_AppLifecycle💧*/import UIKit

extension AppDelegate {
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        /// first time this is called, causes this print to visually interrupt (be in the middle of) the didLoad and didAppear symbols (and the legend explaining them), which looks ugly.  (And, it's obvious anyway, the first time, that the app became active.)
        
        /*if firstBecameActive {print("🔅became active")}
         else {firstBecameActive = true}*/
        
        defaultLoadData(showDate: false)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {                 print("🌔will enter foreground\n")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {                    ///customApplicationStatusPrint("⏸will resign active")
        defaultSaveData(saveDate: true, resetLastLogin: false, showDate: false, pryntDictionary: true)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {                  print("\n🌘entered background")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("terminated")
    }
    
    func customApplicationStatusPrint(_ applicationState: String) { print("\n\(applicationState)")}
}

