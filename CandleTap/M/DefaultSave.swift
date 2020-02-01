/*🔥CandleTap_DefaultSave💧*/import UIKit


func defaultSaveData(saveDate: Bool, resetLastLogin: Bool, showDate: Bool, pryntDictionary: Bool) {
    
    if showDate {
        print(formattedDateString(Date(), roundedDown: false, showYear: true, prefix: "✔︎saved", suffix: "", dateFormat: .fullDayWithSeconds))
    }
    
    let defaults = UserDefaults.standard
    
    if pryntDictionary {printDictionaryTabularized()}
    
    setForKeys(defaults, saveDate: saveDate, resetLastLogin: resetLastLogin)
}


func setForKeys(_ defaults: UserDefaults, saveDate: Bool, resetLastLogin: Bool) {
    
    let (year, _, month, _ , day, weekday, _, hour, minute, _) = getChosenDateComponents(lastArchiveEmailDate, roundedDown: false)
    lastArchiveDateComponents = [year, month, day, weekday, hour, minute]
    lastArchiveEmailDate = dateFromComponents(lastArchiveDateComponents)
    defaults.set(lastArchiveDateComponents, forKey: "savedLastArchiveEmailDate")
    
    if saveDate {
        let (year, _, month, _ , day, weekday, _, hour, minute, _) = getChosenDateComponents(Date(), roundedDown: false)
        lastLoginDateComponents = [year, month, day, weekday, hour, minute]
        if resetLastLogin {lastLoginDate = dateFromComponents(lastLoginDateComponents)}
        defaults.set(lastLoginDateComponents, forKey: "savedLastLoginDate")
    }
}


//func getArchiveDateComponents(_ pair: TradingPair) -> [Int] {
//
//    let (year, monthInt, _, _ , day, _, _, hour, _, _) = getChosenDateComponents(pair.deadline, roundedDown: false)
//
//    return [year, monthInt, day, hour]
//}

