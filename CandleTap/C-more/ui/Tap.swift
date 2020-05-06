/*🔥CandleTap_Tap💧*/import UIKit

extension CollectionVC {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {                            //print("tapped cell")
        
        let layout = downcastLayout!;  let row = indexPath.item;  let column = indexPath.section
        let headers = layout.lockedHeaderRows
        
        if row >= headers && column >= layout.lockedHeaderSections {
            
            //let cell = collectionView.cellForItem(at: indexPath) as! CustomCell
            
            ///print(formattedDateString(cell.cellDate, roundedDown: false, showYear: true, prefix: "selected cell date: ", suffix: "", dateFormat: .fullDay))
            
            /*if viewControllerType == .pairList {
             presentPopupView(column: column, row: row)
             }*/
            
            
//            candleSubset = [[AnyObject]]()
            
            if (column,row) == (1,2) {
                exchangeID = ExchangeID.binance
            }
            
            /*else if (column,row) == (1,1) {
                //krakenUpdated = false
                exchangeID = ExchangeID.kraken
            }
            else {}*/
            
            apiServ.getFeeds(toPlot: exchangeID)
            
            
        }//else {print("selected navbar-embeddd vc's header")}
        
        lastTappedCoordinate = [column, row]
        
        if chartCoordinates.contains(lastTappedCoordinate) {
            gotoView(vc: chartVC)
        }
        
    }
}

