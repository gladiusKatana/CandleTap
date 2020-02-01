/*🔥CandleTap_CellPath💧*/import UIKit

extension CollectionVC {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            registerAndReturnCell(collectionView, at: indexPath)
    }
    
    func doRestOfCellProcessing(cell: CustomCell, indexPath: IndexPath) -> CustomCell {
        
        let customLayout = downcastLayout!
        let row = indexPath.item;                       let column = indexPath.section;
        let headerRows = customLayout.lockedHeaderRows; let headerSections = customLayout.lockedHeaderSections
        
        cell.xyCoordinate = [column, row]
        
        if column < headerSections {cell.backgroundColor = headerColour}
        else {
            if row < headerRows {
                cell.backgroundColor = defaultColour
            }
        }
        
        var text = ""
        
        switch column {
            
        case 0:
            text = tickerPairs[row]
            
        case 1:
            if row < currentPrices.count {
                let priceN = "\(currentPrices[row])"
                text = priceN == "1.0" ? "..." : "\(priceN)"
                if chartCoordinates.contains([column, row]) {cell.titleLabel.textColor = jadeGreen}
            } else {text = "."}
            
        default: cell.titleLabel.text = "."
        }
        
        cell.titleLabel.text = text
        
        if viewControllerType == .archive {cell.backgroundColor = defaultColour}
        
        return cell
    }
}

///For cell title label text truncation
/*if row == 5 && column == 1 {
 if viewControllerType == .hours {findAverageLetterWidthWithCellLabelFont(cell: cell)} /// done here so it's only called once, but can access a cell
 }*/

