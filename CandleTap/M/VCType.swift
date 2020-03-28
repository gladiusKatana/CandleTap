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
            return ""//"Trading Pairs"//   💡Tap green prices to view charts"
            
        case .archive:
            return "Past Trades"
            
        case .chart:
            return ""//"CandleTap"//"ETHBTC ･ Binance ･ 1m"//"CandleTap"   /// set programmatically based on timescale selected
            
        case .popupMenu :
            return "popup menu"
        }
    }
}

