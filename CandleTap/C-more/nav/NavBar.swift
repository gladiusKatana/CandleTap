/*🔥CandleTap_NavBar💧*/import UIKit

extension UIViewController { //CollectionVC
    
    func setupNavBarButtons(greyIndex: Int?) {  //print("setting up nav bar buttons")
        
        let timetableButton = setupButton(selector: #selector(buttonWrapperMethodforPairListVC), title: "timetableImage")
        let archiveButton = setupButton(selector: #selector(buttonWrapperMethodforArchiveVC), title: "calendarImage")
        let wrenchButton = setupButton(selector: #selector(tappedWrench), title: "wrench")
        
        let reloadButton = setupButton(selector: #selector(reloadCVWrapperMethod), title: "reloadButton")
        ///let barButtonColours = [graySeven, graySeven, graySeven, graySeven,]   /// hardcoding button colours (may be easier, depends how many more buttons & colour exceptions)
        
        var barButtonColours = [UIColor]()
        
        let buttons = [timetableButton, archiveButton, wrenchButton, reloadButton]
        
        navigationItem.rightBarButtonItems = buttons
        
        for _ in buttons {
            if barButtonColours.count <= buttons.count {barButtonColours.append(defaultButtonColour)} /// for buttons that present all but current view
        }
        
        for button in buttons {
            
            guard let index = buttons.firstIndex(of: button) else {print("error finding button index"); return}
            
            let defaultColour = barButtonColours[index]
            button.tintColor = defaultColour
            
            if index == greyIndex {
                button.tintColor = defaultGreyoutColour
            }
            
            if button == reloadButton {button.tintColor = grayBarelyThere}
        }
    }
}

