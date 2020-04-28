/*🔥CandleTap_MAPeriods💧*/import UIKit

enum MAPeriod : Int, CaseIterable {
    
    case two = 2
    case seven = 7
    case thirty = 30
    case fifty = 50
    case hundred = 100
    case fiveHundred = 500
    
}

/// Following 3 extensions return the average of all elements in an array
extension Collection where Element: Numeric {
    var total: Element { reduce(0, +) }
}

extension Collection where Element: BinaryInteger {
    var average: Double { isEmpty ? 0 : Double(total) / Double(count) }
}

extension Collection where Element: BinaryFloatingPoint {
    var average: Element { isEmpty ? 0 : total / Element(count) }
}
