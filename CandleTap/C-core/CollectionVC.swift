/*🔥CandleTap_CollectionVC💧*/import UIKit

class CollectionVC: UICollectionViewController, UITextFieldDelegate, UIGestureRecognizerDelegate/*, MFMailComposeViewControllerDelegate*/ {
    
    var viewControllerType = ViewControllerType.pairList;           var downcastLayout: CustomFlowLayout?
    var colourIndex: Int?;                                          var backgroundColour = UIColor.clear
    var showLoadAndAppearIndicationInConsole = false
    
    init(_ vcType: ViewControllerType, backgroundColour: UIColor, colourIndex: Int?,
         collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.viewControllerType = vcType
        self.backgroundColour = backgroundColour
        self.colourIndex = colourIndex
        self.downcastLayout = layout as? CustomFlowLayout
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (downcastLayout!.loadsHorizontally) ? downcastLayout!.cols : downcastLayout!.rows
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (downcastLayout!.loadsHorizontally) ? downcastLayout!.rows : downcastLayout!.cols
    }
    
    func registerAndReturnCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> CustomCell {
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseIdentifier, for: indexPath) as! CustomCell
        cell = doRestOfCellProcessing(cell: cell, indexPath: indexPath)
        return cell
    }
}

