/*🔥CandleTap_DefaultLoad💧*/import UIKit


func defaultLoadData(showDate: Bool) {                                                      //print("(load using defaults)\n")
    
    let defaults = UserDefaults.standard
    
    if let components = defaults.array(forKey: "savedLastLoginDate") {
        lastLoginDateComponents = components
        lastLoginDate = dateFromComponents(lastLoginDateComponents)
        if showDate {pryntLastLoginDate(); pryntCurrentDate()} ///  * may want to modify these methods to adjust cell string (printed in the console only) to adjust for DST
    }
    else { ///print("\nfirst login")
        let (year, _, month, _ , day, weekday, _, hour, minute, _) = getChosenDateComponents(Date(), roundedDown: true)
        lastLoginDateComponents = [year, month, day, weekday, hour, minute]
    }
    
    if let components = defaults.array(forKey: "savedLastArchiveEmailDate") {
        lastArchiveDateComponents = components
        lastArchiveEmailDate = dateFromComponents(lastArchiveDateComponents)
        //if showDate && lastArchiveEmailDate.timeIntervalSince1970 > 0 {pryntArchiveEmailDate()}
    }
    
}

