/*🔥CandleTap_VCType💧*/import UIKit


enum ViewControllerType: Int {
    case initial = 0
    case moneyManagement, pairList, archive, chart, popupMenu
    
    func getNavBarTitle() -> String {
        
        switch self {
            
        case .initial:
            return "(initial)"
            
        case .moneyManagement:
            return "Funds"
            
        case .pairList:
            return "Trading Pairs"
            
        case .archive:
            return "Past Trades"
            
        case .chart:
            return "CandleTap"//🔥//"1d"    /// set programmatically
            
        case .popupMenu :
            return "popup menu"
        }
    }
}

