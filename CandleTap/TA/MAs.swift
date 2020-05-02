/*🔥CandleTap_MAs💧*/import UIKit

func historicalMAs(latestClose: Double) -> [Double] {
    var mas = [Double]()
    var i=0
    for period in MAPeriod.allCases {       //print("ma period to add: \(period.rawValue)")
        
        //if !maSubsets.isEmpty {
        if maSubsets[i].count == period.rawValue {
            maSubsets[i].removeFirst()
        }
        
        if maSubsets[i].count <= period.rawValue {
            maSubsets[i].append(latestClose)      //; print("appended to subset")
        }
        
        let ma = maSubsets[i].average   //; print("subset length \(period.rawValue) has \(maSubsets[i].count) values, average is \(ma)")
        //let maRounded = ma.truncate(places: 8)//.(round(1000000*ma)/1000000)
        mas.append(ma)
        
        i+=1
        //} else {print("ma subsets empty")}
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


//extension Double {
//    /// Rounds the double to decimal places value
//    func rounded(toPlaces places:Int) -> Double {
//        let divisor = pow(10.0, Double(places))
//        return (self * divisor).rounded() / divisor
//    }
//}

//extension Double
//{
//    func truncate(places : Int)-> Double
//    {
//        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
//    }
//}

