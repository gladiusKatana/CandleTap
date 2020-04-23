/*🔥CandleTap_Orientation💧*/import UIKit

extension AppDelegate {
    
    func getOrientationAtLaunch() {
        
        launchHeight = Double(globalWindow.frame.height)
        launchWidth = Double(globalWindow.frame.width)
        
        if launchHeight > launchWidth {
            launchOrientation = "portrait"
            lastStatusBarHeight = 20
        }
        else if launchHeight < launchWidth {
            launchOrientation = "landscape"
            lastStatusBarHeight = 0
        }
        else {
            launchOrientation = " ?"                        ; print("launch orientation undefined")
            lastStatusBarHeight = 99
        }
        
        currentOrientation = launchOrientation
        previousOrientation = launchOrientation
    }
}


func checkOrientation() {
    
    if frameHeight > frameWidth {
        currentOrientation = "portrait"
    }
    else if frameHeight < frameWidth {
        currentOrientation = "landscape"
    }
    else {print("\n\nUm, global window frame height & width are equal...")} /// shouldn't get called... unless Apple decides to make a square device
}

