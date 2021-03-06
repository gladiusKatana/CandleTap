/*🔥CandleTap_MAs💧*/import UIKit

func historicalMAs(latestClose: Double) -> [Double] {
    var mas = [Double]()
    var i=0                                             
    for period in MAPeriod.allCases {
        
        let maPeriod = period.rawValue                  //print("ma period to add: \(maPeriod)")
        
        if maSubsets[i].count == maPeriod {
            maSubsets[i].removeFirst()
        }
        
        if maSubsets[i].count <= maPeriod {
            maSubsets[i].append(latestClose)            //; print("appended to subset")
        }
        
        var ma = -1.0; var maRounded = -1.0
        
        if maSubsets[i].count == maPeriod {
            ma = maSubsets[i].average                   //; print("subset length \(maPeriod) has \(maSubsets[i].count) values, average is \(ma)")
            maRounded = ma.rounded(toPlaces: 10)        ///P134−ROUND(AVERAGE(F7:F134),10) //<- template Numbers formula for MA correctness tests
        }
        
        mas.append(maRounded)                           //; print("appending \(maPeriod)-period moving average \(ma)")
        
        i+=1
    }
    
    return mas
}

enum MAPeriod : Int, CaseIterable {
    case two = 2
    case three = 3
    case seven = 7
    case twenty = 20
    case thirty = 30
    case fifty = 50
    case hundred = 100
    case oneTwentyEight = 128
    case twoHundred = 200
    case fiveHundred = 500
}

/// Following 3 extensions return the average of all elements in an array

extension Collection where Element: Numeric {
    var total: Element { reduce(0, +) }
}

extension Collection where Element: BinaryFloatingPoint {
    var average: Element { isEmpty ? 0 : total / Element(count) }
}

//extension Collection where Element: BinaryInteger {
//    var average: Double { isEmpty ? 0 : Double(total) / Double(count) }
//}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

//extension Double
//{
//    func truncate(places : Int)-> Double
//    {
//        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
//    }
//}

