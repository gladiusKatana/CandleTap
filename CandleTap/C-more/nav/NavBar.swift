/*🔥CandleTap_NavBar💧*/import UIKit

extension UIViewController { //CollectionVC
    
    func setupNavBarButtons(greyIndex: Int?) {  //print("setting up nav bar buttons")
        
        let timetableButton = setupButton(selector: #selector(buttonWrapperMethodforPairListVC), title: "calendarImage")
        //let archiveButton = setupButton(selector: #selector(buttonWrapperMethodforArchiveVC), title: "wrench")
        let wrenchButton = setupButton(selector: #selector(goToChartViaButton), title: "timetableImage")
        let reloadButton = setupButton(selector: #selector(reloadCVWrapperMethod), title: "reloadButton")
        
        var barButtonColours = [UIColor]()
        
        let buttons = [timetableButton, /*archiveButton, */wrenchButton, reloadButton]
        
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

