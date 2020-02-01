/*🔥CandleTap_PCellPath💧*/import UIKit

extension PopupMenuVC {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.popupReuseIdentifier, for: indexPath) as! CustomCell
        let customLayout = downcastLayout!
        let row = indexPath.item
        
        if row < customLayout.lockedHeaderRows
            //|| column < customLayout.lockedHeaderSections {           // our popup menu has no need for header columns
        {
            cell.backgroundColor = popupMenuLightGray
            cell.titleLabel.text = "Act on Pair"
            cell.titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        }
        else {
            cell.backgroundColor = cellDefaultColour
            cell.titleLabel.text = PairStatus.allCases[row - 1].caseName()
            cell.titleLabel.textColor = .black
        }
        
        return cell
    }
}

