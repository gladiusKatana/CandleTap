/*🔥CandleTap_DateRefresh💧*/import UIKit

extension CollectionVC {
    
    func periodicDateRefresh(completion: () -> ()) {                        //print("·", terminator: "")
        
            if Calendar.current.component(.second, from: Date()) == 0 {     //print("minute ticked over")
//                print("Date: \(Date())")
//                getChartDataAndPrepareToPlot(plotAllCandles: true)
            }
//            else {
//                getChartDataAndPrepareToPlot(plotAllCandles: false)
//            }
        
        getChartDataAndPrepareToPlot(plotAllCandles: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { /// must be on main queue: periodic callback inside the completion handler, is called on a background thread
            topVC.reloadCV()
        }
        
        completion()
    }
    
    func kickoffTimer() {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.periodicDateRefresh(){self?.kickoffTimer()}
        }
    }
}

func getChartDataAndPrepareToPlot(plotAllCandles: Bool) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        
        apiServ.getFeeds()
        
        
        if chartDisplayed {
            
            assignCandleSubset()
            
            chartVC.getChart()
        }
    }
}

