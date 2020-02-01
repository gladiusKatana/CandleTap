/*🔥CandleTap_SetTopVC💧*/import UIKit

extension UIViewController { 
    
    func setTopViewController() {
        
        guard let viewControllers = self.navigationController?.viewControllers else { // despite the s, should only contain 1 view controller
            print("...could not bind view controller array")
            return
        }
        
        //print("view controllers: \(viewControllers)")
        
        guard viewControllers.count == 1 else {
            print("\n\nnavigation controller, somehow, contains more than one view controller at once  ... \n\nvc count: \(viewControllers.count)   \n\nvcs: \(viewControllers)'\n\n")
            return
        }
        
        //        guard let customVC = viewControllers[0] as? CollectionVC else {
        //            print("...could not downcast vc as collection vc")
        //            return
        //        }
        
        if let customCollectionVC = viewControllers[0] as? CollectionVC {
            topVC = customCollectionVC
        }
        else {
            print("...could not downcast vc as collection vc")
        }
        
        //        if let customVC = viewControllers[0] as? CandleVC {
        //            topVC = customVC
        //        }
        //        else {
        //            print("...could not downcast vc as candle vc")
        //        }
        
        //        topVC = customVC
    }
    
    func pryntTopmostVCType() {
        if let topViewController = self.navigationController?.viewControllers[0] as? CollectionVC {
            print("topmost view controller: \(String(describing: topViewController.viewControllerType))")
        }
        
        if let topViewController = self.navigationController?.viewControllers[0] as? ChartVC {
            print("topmost view controller: \(String(describing: topViewController.viewControllerType))")
        }
    }
}

