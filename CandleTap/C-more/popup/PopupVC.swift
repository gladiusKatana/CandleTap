/*🔥CandleTap_PopupVC💧*/import UIKit

class PopupMenuVC: UICollectionViewController, UIGestureRecognizerDelegate {
    
    var downcastLayout : CustomFlowLayout?
    var vcType = ViewControllerType.initial
    
    init(_ vcType: ViewControllerType, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.downcastLayout = layout as? CustomFlowLayout
        
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (downcastLayout!.loadsHorizontally) ? downcastLayout!.cols : downcastLayout!.rows
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (downcastLayout!.loadsHorizontally) ? downcastLayout!.rows : downcastLayout!.cols
    }
    
    
    //    func addToArchives(_ pair: TradingPair) {     print("adding task '\(pair.pairTickers)' to archives")
    //    }
    
}

