/*🔥CandleTap_AddPopup💧*/import UIKit

extension CollectionVC {
    
    func presentPopupView(column: Int, row: Int) {                    //print("presenting popup")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            if !popupMenuDisplayed {
                
                let layout = self.downcastLayout!
                let popupMenuLayout = pairActionVC.downcastLayout!
                
                let headerRows = layout.lockedHeaderRows
                let cols = CGFloat(popupMenuLayout.cols)
                let rows = CGFloat(popupMenuLayout.rows)
                
                let widthFactor = CGFloat(2)
                let cellHeight = layout.heightPlusSpace;    let cellWidth = layout.widthPlusSpace;
                popupMenuLayout.cellHeight = cellHeight;    popupMenuLayout.cellWidth = cellWidth * widthFactor
                
                var x = cellWidth * CGFloat(column + 1)
                
                let yO = CGFloat(navBarHeight + statusBarHeight) + cellHeight * CGFloat(headerRows - 1)
                var y = yO + cellHeight * CGFloat(row - headerRows)
                
                if column >= 2 {x = cellWidth * CGFloat(column - 2)}
                if row > 22 {y = CGFloat(navBarHeight + statusBarHeight) + cellHeight * CGFloat(row)}
                
                let popupFrameHeight = cellHeight * rows
                let popupCollectionViewFrame = CGRect(x: x, y: y, width: cellWidth * cols * widthFactor, height: popupFrameHeight)
                
                pairActionVC.downcastLayout?.customFrame = popupCollectionViewFrame
                pairActionVC.collectionView.frame = popupCollectionViewFrame
                
                
                let hscale = moneyManagementVC.downcastLayout!.autoFitHeightScale!     //* make sure this is extensible (ie,  if column >= 6 )
                pairActionVC.collectionView?.scrollIndicatorInsets =
                    UIEdgeInsets(top: pairActionVC.downcastLayout!.cellHeight! * hscale, left: 0, bottom: 0, right: 0)
                pairActionVC.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
                pairActionVC.collectionView.isUserInteractionEnabled = true
                
                let switchViewHeight = cellHeight * rows
                pairActionSwitchView = PopupSwitchView(frame: CGRect(x: x, y: y + popupCollectionViewFrame.height,
                                                                     width: cellWidth * widthFactor, height: switchViewHeight))
                pairActionSwitchView.backgroundColor = popupMenuLightGray
                
                topVC.view.addSubview(pairActionVC.view)            //; print("----------------adding popup")
                topVC.view.addSubview(pairActionSwitchView)         //; print("adding switch")
                
                pairActionVC.becomeFirstResponder()
                popupMenuDisplayed = true
                pairActionVC.collectionView.reloadData()
                
                ///taskTaggingViewController.keepScrollIndicatorsVisible()
                //                self.addCellBorder() //*
            }
        }
    }
}

