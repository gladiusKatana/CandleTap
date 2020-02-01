/*🔥CandleTap_Prepare💧*/import UIKit

extension CustomFlowLayout {
    
    override func prepare() {                                                       //print("◆", terminator: "")
        
        //checkOrientation()                                                        ///; print("current orientation: \(currentOrientation)")
        calculateAndResetSizes()
        
        //        if previousOrientation != currentOrientation {                            //print("prepare(rotated to \(currentOrientation)):")
        //            previousOrientation = currentOrientation
        //
        //            //chartOrientation = currentOrientation
        //
        //            /*
        //            if !justDismissedChart {
        //                topVC.setupTitleAndPresentViewController(vc: topVC) { () -> () in
        //                    //topVC.reloadCV() /// only really useful for cell font size readjustment upon rotations / other layout scaling changes
        //                }
        //            }
        //            else {justDismissedChart = false}
        //            */
        //
        //            //topVC.setupTitleAndPresentViewController(vc: topVC)
        //        }
    }
    
    func calculateAndResetSizes() {
        (cellWidth, cellHeight) = calculateSizes(); resetDimensionIfSquareCellsEnabled()
        widthPlusSpace = cellWidth! + hSpace;       heightPlusSpace = cellHeight! + vSpace
        
        if !embeddedInNavController {compensateForNavigationAndStatusBars(forCollectionVC: pairActionVC, withDelta: 0)}
        else {
            var statusBarDelta = 0.0
            let statusBarTestHeight = (globalWindow.windowScene?.statusBarManager!.statusBarFrame)!.height
            if statusBarTestHeight > 20 {
                statusBarDelta = Double(statusBarTestHeight - 20)
            }
            
            compensateForNavigationAndStatusBars(forCollectionVC: topVC, withDelta: statusBarDelta)
        }
    }
    
    func compensateForNavigationAndStatusBars(forCollectionVC collectVC: UICollectionViewController, withDelta delta: Double) {
        yOffset = collectVC.collectionView!.contentOffset.y + CGFloat(navBarHeight + statusBarHeight - delta)  //print("yo: \(yOffSet)")
        xOffSet = collectVC.collectionView!.contentOffset.x
    }
}

