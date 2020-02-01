/*🔥CandleTap_EmailVC💧*/import UIKit; import MessageUI

class EmailComposer: UIViewController, MFMailComposeViewControllerDelegate {
    
    lazy var emailComposeVC = MFMailComposeViewController()
    
    override func viewDidLoad() {                                                               //print("email Composer didLoad")
        super.viewDidLoad()
    }
    
    func canSendEmail() -> Bool {                                                               /// A wrapper method to indicate whether or not an email
        return MFMailComposeViewController.canSendMail()                                        /// can be sent from the user's device
    }
    
    func configureEmailComposeVC()  -> MFMailComposeViewController {
        emailComposeVC = MFMailComposeViewController()
        emailComposeVC.mailComposeDelegate = self                                               ///as? MFMailComposeViewControllerDelegate
        
        let tempEmails = ["garthsnyder1@gmail.com"]
        emailComposeVC.setToRecipients(tempEmails)
        
        let path = archiveVC.createArchiveUrl()
        //let count = archiveDescriptions.count ///let s = (count > 1) ? "s" : ""
        
        let messageText = "Latest trades..."
        emailComposeVC.setMessageBody(messageText, isHTML: false)                               /// <p> is for isHTML: true
        
        emailComposeVC.setSubject("[Nidhamu] Export to Excel") /// No use in using multiple spaces between words here, Gmail prohibits > 1 consecutive spaces
        
        do {
            let attachmentData = try Data(contentsOf: path)
            emailComposeVC.addAttachmentData(attachmentData, mimeType: "text/csv", fileName: "Tagged tasks (\(dateString)).csv")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25 ) {
                self.present(self.emailComposeVC, animated: true, completion: nil)
            }
            
        } catch let error {print("We have encountered error \(error.localizedDescription)")}
        
        return emailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {      //print("\nEMAIL dismissed📪\n")
        emailComposer.emailComposeVC.view.removeFromSuperview() ///; backgroundVC.view.removeFromSuperview()
        
        updateArchiveRelatedData(result: result)
        
        ///print("handled email with result \(result.rawValue)")
    }
}

func updateArchiveRelatedData(result: MFMailComposeResult) {
    if result == .sent {
        lastArchiveEmailDate = Date()
        //deleteArchivesLocally()
        defaultSaveData(saveDate: false, resetLastLogin: false, showDate: true, pryntDictionary: false)
        topVC.reloadCV()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25 ) {
            topVC.gotoView(vc: moneyManagementVC)
        }
    }
}

//func deleteArchivesLocally() {
//}

