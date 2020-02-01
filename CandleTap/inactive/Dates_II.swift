/*🔥CandleTap_Dates_II💧*/import UIKit

//func makeDateFrom(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> Date {
//    let calendar = Calendar(identifier: .gregorian)
//    // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
//    let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
//    return calendar.date(from: components)!
//}


//func dateFromInts(_ dateComponents: [Int]) -> Date { /// Note, weekday inot needed to create a Date; it's 'along for the ride', somewhat, & used for prints, eg in pryntLastLoginDate()
//    let yearLoaded = dateComponents[0]                                      ///; print("year loaded: \(yearLoaded)")
//    let monthLoaded = dateComponents[1]                                     ///; print("month loaded: \(monthLoaded)")
//    let dayLoaded = dateComponents[2]                                       ///; print("day loaded: \(dayLoaded)")
//    let hourLoaded = dateComponents[3]                                      ///; print("hour loaded: \(hourLoaded)")
//
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy/MM/dd HH"
//
//    guard let date = formatter.date(from: "\(yearLoaded)/\(monthLoaded)/\(dayLoaded) \(hourLoaded)") else {
//        print("could not create date with loaded input, returning current date instead")
//        return Date()
//    }
//    return date
//}


//func truncateMins(_ inputDate: Date) -> Date {
//    let mn = 0
//    let (year, _, month, _ , day, _, _, hour, _, _) = getChosenDateComponents(inputDate, roundedDown: false)
//    let formatter = DateFormatter();    formatter.dateFormat = "yyyy/MM/dd HH:mm"
//
//    guard let date = formatter.date(from: "\(year)/\(month)/\(day) \(hour):\(mn)") else {
//        print("could not create truncated date with input, returning current date instead")
//        return Date()
//    }
//    return date
//}


//extension Date {
//    func isBetween(_ date1: Date, and date2: Date) -> Bool {
//        return (min(date1, date2) ... max(date1, date2)).contains(self)
//        ///return (date1 ... date2).contains(self)
//    }
//}
