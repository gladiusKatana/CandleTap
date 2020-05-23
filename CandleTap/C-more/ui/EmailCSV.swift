/*🔥CandleTap_EmailCSV💧*/import UIKit

extension CollectionVC {
    
    func createArchiveUrl() -> URL {
        
        dateString = formattedDateString(Date(), roundedDown: false, showYear: true,
                                         prefix: "", suffix: "", dateFormat: .archiveCSVTitle)
        fileName = "Historical OHLCs (\(dateString)).csv" ///don't insert a space after "as of" : formattedDateString(:) already builds one in
        
        var returnPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("☹️")
        if let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName) {
            
            var csvText = ""
            let s = "," //";"   ///If exporting to Numbers, "Comma Separated Values" is a misnomer -- must separate columns by semicolon
            csvText.append("Timestamp\(s)Date(UTC)\(s)Open\(s)High\(s)Low\(s)Close\(s)Count\(s)Colour\(s)")
            for period in MAPeriod.allCases {csvText.append("\(period.rawValue)MA\(s)")}//last \(s) causes extra column @ end but it's actually useful
            csvText.append("\n")
            
            var historicalData = binanceHistorical // krakenHistorical {
            historicalData.removeFirst(nineSampleSize); historicalData.removeLast(nineSampleSize) //remove padding items (were used for charts)
            
            for datum in historicalData {
                var csv = datum.map {"\($0)"}.joined(separator: s)
                csv = csv.filter{$0 != "["}
                csv = csv.filter{$0 != "]"}                         //; print("csv: \(csv)")
                csvText.append("\(csv)\(s)\(s)\(s)\n")
            }                                                       //; print("csv text: \(csvText)")
            
            do {
                try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
            } catch {print("Failed to create csv file, error:\n\(error)")}
            
            returnPath = path
        }
            
        else {print("failed to create url")}
        return returnPath ?? NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("☹️")!
    }
    
    func presentEmail() {                                           print("📪EMAIL")
        
        if emailComposer.canSendEmail() {
            emailComposer.emailComposeVC = emailComposer.configureEmailComposeVC()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { ///Needs time, for configuration of email composer to complete, or top subject font can be seen resizing
                globalWindow.addSubview(emailComposer.emailComposeVC.view)
            }
        }
        else {
            let alert = UIAlertController(title: "Cannot Send Email", message: "Your device is not able to send email.\nNOTE: If you have not installed the default Mail application for iOS, try simply installing Mail from the App Store, then closing and re-opening this app.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}

