/*🔥CandleTap_Reload💧*/import UIKit

extension UIViewController { //CollectionVC
    
    
    @objc func reloadCV() {
        
        //print("↺")
        
        if let collectionView = topVC.collectionView {
            collectionView.reloadData()
        }
    }
    
    
    func reloadCollectionViewAfterDelay(_ timeDelay: Double) {
        
        print("↺d")
        
        if let collectionView = topVC.collectionView {
            DispatchQueue.main.asyncAfter(deadline: .now() + timeDelay) {
                collectionView.reloadData()
            }
        }
    }
    
}

