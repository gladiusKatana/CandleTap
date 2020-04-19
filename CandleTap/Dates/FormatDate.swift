/*🔥CandleTap_FormatDate💧*/import UIKit

func formattedDateString(_ date: Date, roundedDown: Bool, showYear: Bool, prefix: String?, suffix: String, dateFormat: CustomDateFormat) -> String { // * probably will clean this method up at some point
    
    let (year, _, month, mnth, day, weekday, wkdy, hour, minute, second) = getChosenDateComponents(date, roundedDown: roundedDown)
    
    var minTwoDigits = "\(minute)";             if minute < 10 {minTwoDigits = "0\(minute)"}
    var sec2Digs = "\(second)";                 if second < 10 {sec2Digs = "0\(second)"}
    var ampm = ""
    
    let prx = (prefix == "") ? " " : "\(prefix ?? "") "
    let dy = day < 10 ? "0\(day)" : "\(day)"
    
    var hr = (hour < 13) ? hour : hour - 12
    if hr == 0 {hr = 12}                            // * this is just to make a string representing the date, not the date itself
    if hour < 12 {ampm = "am"} else {ampm = "pm"}   // since hr is an integer from 0 to 23
    
    let yearString = showYear /*&& (month == "January" || month == "December")*/ ? "\(year)" : ""
    
    switch dateFormat {
    case .fullDay:                  return "\(prx)\(weekday) \(month) \(day), \(yearString), \(hr):\(minTwoDigits)\(ampm)\(suffix)"
        
    case .fullDayWithYear:          return "\(prx)\(weekday) \(month) \(day), \(year) \(hr):\(minTwoDigits)\(ampm)\(suffix)"
        
    case .fullDayWithSeconds:       return "\(prx)\(weekday) \(month) \(day), \(yearString)\(hr):\(minTwoDigits):\(sec2Digs)\(ampm)\(suffix)"
        
    case .fullDayShortForm:         return "\(prx)\(wkdy) \(mnth) \(day)\(yearString), \(hr)\(ampm)\(suffix)"
        
    case .fullDayShortFormNoDots:
        return "\(prx)\(weekday.prefix(3)) \(month.prefix(3)) \(day), \(yearString), \(hr)\(ampm)\(suffix)"
        
    case .archiveFormat:            if hour < 12 {ampm = "AM"} else {ampm = "PM"}
    return "\(weekday) \(dy) \(month) \(year) \(hr)\(ampm)"
        /// not for use in csv emails (timestamps used instead; can paste csv data into template spreadsheet to see dates * )
        ///* IF dates were used in csv emails, would need to use atypical, larger colon in .archiveFormat return ('꞉' , not ':'), since a (regular) colon is a .csv column separator in Mac Numbers
        
    case .archiveCSVTitle:  return "\(weekday.prefix(3)) \(month.prefix(3)) \(day), \(year), \(hr)꞉\(minTwoDigits)\(ampm)"/// see  **  above
        
    case .hourOnly:                 return "\(hr)\(ampm)"
        
    case .hourAndMinute:            return "\(hr):\(minTwoDigits)\(ampm)"
        
    case .monthAndDay:              return "\(month.prefix(3)) \(day)"
        
    default:    return "\(prx)\(weekday) \(hr)\(ampm)"
    }
}

enum CustomDateFormat: Int {
    case hourlyTimeBlock = 0; case quarterDayTimeBlock, fullDay, fullDayWithYear, fullDayWithSeconds, fullDayShortForm, fullDayShortFormNoDots, archiveFormat, archiveCSVTitle, hourOnly, hourAndMinute, monthAndDay
}

