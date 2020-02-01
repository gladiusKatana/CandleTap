/*🔥CandleTap_GoToVC💧*/import UIKit

extension UIViewController { //CollectionVC
    
    func gotoView(vc: UIViewController) {                                                   //print("\ngoing to vc \(vc)")
        
        if self.navigationController?.viewControllers[0] != vc
            || vc == chartVC
        {
            //if topVC != vc {
            
            //if vc == chartVC {print("re-presented chart")}
            
            globalWindow.backgroundColor = defaultColour
            backgroundVC.view.backgroundColor = globalWindow.backgroundColor
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.setupTitleAndPresentViewController(vc: vc) { () -> () in
                    ///(empty; may remove the completion handler from this method)
                }
                //self.setupTitleAndPresentViewController(vc: vc)
            }
            
        } else {print("you're already looking at the \(topVC.viewControllerType)-view")}
    }
    
    func setupTitleAndPresentViewController(vc: UIViewController, completion: () -> ()) {   //print("\ndismissing/presenting vc: \(vc)")
        setupAndPresent(vc: vc)
        completion()
    }
    /*func setupTitleAndPresentViewController(vc: UIViewController) {                       //print("\ndismissing/presenting vc: \(vc)")
     setupAndPresent(vc: vc)
     }*/
    
    func setupAndPresent(vc: UIViewController) {                                            //print("setup and present")
        dismissNavController {
            let newVC = UINavigationController(rootViewController: vc)
            newVC.modalPresentationStyle = .fullScreen  /// disabling this prevents CollectionVCs with non-nav-bar-embedded layouts from being presented
            
            navController?.present(newVC, animated: tempRescalingBool, completion: nil)
            //self.setTopViewController()// try commenting this, you should see: vc of type 'initial' was root vc when this method was called
        }
    }
    
    func dismissNavController(completion: @escaping () -> ()) {
        navController?.dismiss(animated: false, completion: nil)
        completion()
    }
}

