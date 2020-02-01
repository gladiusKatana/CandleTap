/*🔥CandleTap_Attributes💧*/import UIKit

extension CustomFlowLayout { 
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {         //print("layout for elements...")
        var attributesForElements = [UICollectionViewLayoutAttributes]()
        
        for j in 0 ..< cols {
            for i in 0 ..< rows {
                var ip : IndexPath = IndexPath()
                
                if !loadsHorizontally {ip = IndexPath(item: i, section: j)}
                else                {ip = IndexPath(item: j, section: i)}
                
                let attribute = UICollectionViewLayoutAttributes(forCellWith: ip) //let attribute = self.layoutAttributesForItem(at: ip)!
                let xDefault : CGFloat = CGFloat(j) * widthPlusSpace
                
                var xO = CGFloat(0);    var yO = CGFloat(0)                                                     //; print("*", terminator: "")
                
                if j < lockedHeaderSections {
                    xO = xOffSet + CGFloat(j) * widthPlusSpace
                } else {xO = xDefault}
                
                if i < lockedHeaderRows {
                    if self == pairActionLayout {yO = yOffset - CGFloat(navBarHeight + statusBarHeight)}
                    else {
                        yO = yOffset + CGFloat(i) * heightPlusSpace
                    }
                }
                else {
                    let headerDelta = yOffset + CGFloat(lockedHeaderRows) * heightPlusSpace
                    let y = headerDelta + CGFloat(i - lockedHeaderRows) * heightPlusSpace
                    
                    if self == pairActionLayout {yO = y - CGFloat(navBarHeight + statusBarHeight)}
                    else {
                        yO = y
                    }
                }
                
                attribute.frame = CGRect(x: xO, y: yO, width: cellWidth!, height: cellHeight!)
                setZIndex(row: i, section: j, cellAttributes: attribute)
                attributesForElements.append(attribute)
            }
        }
        
        return attributesForElements
    }
}

