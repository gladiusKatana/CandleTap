/*🔥CandleTap_Buttons💧*/import UIKit

extension UIViewController { //CollectionVC
    
    func setupButton(selector: Selector, title: String) -> UIBarButtonItem {
        let image = UIImage(named: title)?.withRenderingMode(.alwaysTemplate)
        let button = UIBarButtonItem(image: image, landscapeImagePhone: image, style: .plain, target: self, action: selector)
        return button
    }
    
    
    @objc func reloadCVWrapperMethod() {    print("↺(button)")
        reloadCV()
    }
    
    
    @objc func goToChartViaButton() {             //print("tapped the wrench")
        ///assignCandleSubset()
        gotoView(vc: chartVC)
    }
    
    
    @objc func buttonWrapperMethodforArchiveVC() {
        gotoView(vc: archiveVC)
    }
    
    
    @objc func buttonWrapperMethodforPairListVC() {
        gotoView(vc: pairListVC)
    }
}

