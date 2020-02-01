/*🔥CandleTap_CellIndexPath💧*/import UIKit


struct CellIndexPath<T: Hashable, U: Hashable>: Hashable {
    let values : (T, U)
    func hash(into hasher: inout Hasher) {
        let (a,b) = values
        hasher.combine(a.hashValue &* 31 &+ b.hashValue)
    }
}


func ==<T:Hashable,U:Hashable>(lhs: CellIndexPath<T,U>,
                               rhs: CellIndexPath<T,U>) -> Bool {   /// comparison function for conforming to Equatable protocol
    return lhs.values == rhs.values
}


//extension CollectionVC {
//    
//    func addToCellItem(withColumn column: Int, withRow row: Int, textEntered: String, deadline: Date, withStatus: PairStatus?) {
//        
//        var status : PairStatus
//        if withStatus != nil {status = withStatus!} else {status = .inactive}
//        
//        let timeBlockToAdd = CellIndexPath(values:(column, row))
//        let tradingPair = TradingPair(pairTickers: textEntered, deadline: deadline, status: status)
//        
//        if itemAtIndexPath[timeBlockToAdd] != nil {
//            itemAtIndexPath[timeBlockToAdd]! = tradingPair
//        }
//            
//        else {
//            itemAtIndexPath[timeBlockToAdd] = tradingPair
//        }
//        
//    }
//}

