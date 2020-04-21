/*🔥CandleTap_EmailCSV💧*/import UIKit

extension CollectionVC {
    
    func presentEmail() { //print("\n📪EMAIL\n")
        
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
    
    func createArchiveUrl() -> URL {
        
        dateString = formattedDateString(Date(), roundedDown: false, showYear: true,
                                         prefix: "", suffix: "", dateFormat: .archiveCSVTitle)
        fileName = "Historical OHLCs (\(dateString)).csv" ///don't insert a space after "as of" : formattedDateString(:) already builds one in
        
        var returnPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("☹️")
        if let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName) {
            
            var csvText = ""
            csvText.append(".; .; Open; High; Low; Close\n")
            
            let ohlcs = binanceETHBTCHistoricalForPrinting[0]
            for ohlc in ohlcs { /// Comma Separated is a misnomer, exporting to Numbers-- must separate columns by semicolon
                let dot = "."
                csvText.append("\(dot);\(dot);\(ohlc[2]);\(ohlc[3]);\(ohlc[4]);\(ohlc[5])\n") ///;\(archiveTaskDateStrings[i])
            }
            
            do {
                try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("Failed to create csv file")
                print("\(error)")
            }
            
            returnPath = path
        }
            
        else {print("failed to create url")}
        
        return returnPath ?? NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("☹️")!
    }
}

