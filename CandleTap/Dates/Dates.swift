/*🔥CandleTap_Dates💧*/import UIKit

func dateFromComponents(_ dateComponents: [Any]) -> Date { /// Note, weekday not needed to create a Date; it's used for prints, eg in pryntLastLoginDate()
    let yearLoaded = dateComponents[0] as! Int                              ///; print("year loaded: \(yearLoaded)")                                    // will probably replace with...
    let monthLoaded = dateComponents[1] as! String                          ///; print("month loaded: \(monthLoaded)")                              //... conditional downcasts,...
    let monthLoadedInt = months.firstIndex(of: monthLoaded)! + 1            ///; print("int: \(monthLoadedInt)")                                            //...rather than forced ones
    let dayLoaded = dateComponents[2] as! Int                               ///; print("day loaded: \(dayLoaded)")                                      // --- (need to revamp date code)
    //let weekdayLoaded = array[3] as! String                               ///; print("weekday loaded: \(weekdayLoaded)")
    let hourLoaded = dateComponents[4] as! Int                              ///; print("hour loaded: \(hourLoaded)")
    let minuteLoaded = dateComponents[5] as! Int                            ///; print("minute loaded: \(minuteLoaded)")
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    
    guard let date = formatter.date(from: "\(yearLoaded)/\(monthLoadedInt)/\(dayLoaded) \(hourLoaded):\(minuteLoaded)") else {
        print("could not create date with loaded input, returning current date instead")
        return Date()
    }
    return date
}


func getChosenDateComponents(_ inputDate: Date, roundedDown: Bool)
    
    -> (Int, Int, String, String, Int, String, String, Int, Int, Int) {
        
        let year = Calendar.current.component(.year, from: inputDate)
        
        let monthInt = Calendar.current.component(.month, from: inputDate)
        
        let month = months[monthInt - 1]
        let mnth = monthsAbbreviated[monthInt - 1]
        
        let day = Calendar.current.component(.day, from: inputDate)
        
        let weekday = fullWeekdaysDefaultOrder[Calendar.current.component(.weekday, from: inputDate) - 1]
        let wkdy = customWkdysDefaultOrder[Calendar.current.component(.weekday, from: inputDate) - 1]
        
        let hour = Calendar.current.component(.hour, from: inputDate)
        
        var minute : Int
        if roundedDown {
            minute = 0
        } else {
            minute = Calendar.current.component(.minute, from: inputDate)
        }
        
        let second = Calendar.current.component(.second, from: inputDate)
        
        return (year, monthInt, month, mnth, day, weekday, wkdy, hour, minute, second)  /// MAY CRASH IF DEVICE  NOT  ON 24HR TIME (double check bug is gone;)
}

