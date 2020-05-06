/*🔥CandleTap_Gestures💧*/import UIKit

extension UIViewController {
    
    
    func setupPinchToExit() {
        
        dismissPinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        self.view.addGestureRecognizer(dismissPinch)
        //justPinched = false
        
    }
    
    @objc func handlePinch() {
        
        if !justPinched { justPinched = true
            self.gotoView(vc: pairListVC) ///pairListVC.setupAndPresent(vc: pairListVC)
        }
        
    }
    
    
    @objc func setupTapToJumpBetweenNines() {
        
        nineSkipTap = UITapGestureRecognizer(target: self, action: #selector(jumpBetweenNines))
        self.view.addGestureRecognizer(nineSkipTap)
    }
    
}

