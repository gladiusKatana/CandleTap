/*🔥CandleTap_Sequential💧*/import UIKit

func sequentialHistorical(lastFiveCloses: [Double]) -> (Int?, String) {
    
    var colourString = "" //G for green, R for red
    var returnInt = 0
    
    let current = lastFiveCloses[4]
    let fourAgo = lastFiveCloses[0]
    
    if current > fourAgo {                                          //print("----------Seq_is \(current) > \(fourAgo) ? YES\n")
        if reds != 0 {reds = 0}
        
        if greens == 9 {                                            //print("green 9!")
            greens = 0
            ///greenNines += 1  // don't do it here, causes a bug
        }
        
        greens += 1
        colourString = "G"
        returnInt = greens
    }
        
    else if current < fourAgo {
        if greens != 0 {greens = 0}
        
        if reds == 9 {                                              //print("red 9!")
            reds = 0
            ///redNines += 1    // don't do it here, causes a bug
        }
        
        reds += 1
        colourString = "R"
        returnInt = reds
    }
        
    else {greens = 0   ; colourString = ""}
    return (returnInt, colourString)
}

func displayNineFrequency(candleCount: Int) {
    print("")
    ninePryntHelper(greenNineInt: greenNines, redNineInt: redNines, appendString: "", candleCount: candleCount)
    ninePryntHelper(greenNineInt: chartGreenNines, redNineInt: chartRedNines, appendString: "(check)", candleCount: candleCount)
}

func ninePryntHelper(greenNineInt: Int, redNineInt: Int, appendString: String, candleCount: Int) {
    let greenFrequency = (100 * Double(greenNines) / Double(candleCount)).rounded(toPlaces: 2)
    let redFrequency = (100 * Double(redNines) / Double(candleCount)).rounded(toPlaces: 2)
    
    let nines = greenNineInt + redNineInt // may expand scope
    print("\(nines) nines: \(greenNineInt) green (\(greenFrequency) %), \(redNineInt) red (\(redFrequency) %) \(appendString)")
}

