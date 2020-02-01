/*🔥CandleTap_TradingPair💧*/import UIKit


class TradingPair: NSObject {
    
    var pairTickers = ""
    var pairStatus = PairStatus.inactive
    var deadline = Date() /// make optional
    
    init(pairTickers: String, deadline: Date, status: PairStatus) {
        self.pairTickers = pairTickers
        self.deadline = deadline
        self.pairStatus = status
    }
}

enum PairStatus: Int, CaseIterable {
    
    case inactive = 0; case watching, openLong, openShort
    
    //    func simpleDescription() -> String {
    //        switch self {
    //        case .inactive:     return "
    //        case .watching:     return "
    //        case .openLong:     return "
    //        case .openShort:    return "
    //        }
    //    }
    
    func caseName() -> String {
        switch self {
        case .inactive:     return "Inactive"
        case .watching:     return "Watching"
        case .openLong:     return "OpenLong"
        case .openShort:    return "OpenShort"
        }
    }
}

