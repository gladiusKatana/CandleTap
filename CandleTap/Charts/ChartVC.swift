/*🔥CandleTap_ChartVC💧*/import UIKit

class ChartVC: UIViewController {
    
    var viewControllerType = ViewControllerType.chart
    
    init(_ vcType: ViewControllerType) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllerType = vcType
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

