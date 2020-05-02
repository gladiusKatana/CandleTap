/*🔥CandleTap_Sequential💧*/import UIKit

func sequentialHistorical(lastFiveCloses: [Double]) -> (Int?, String) {
    
    var colourString = "" //G for green, R for red
    var returnInt = 0
    
    let current = lastFiveCloses[4]
    let fourAgo = lastFiveCloses[0]
    
    if current > fourAgo {                      //print("----------Seq_is \(current) > \(fourAgo) ? YES\n")
        if reds != 0 {reds = 0}
        
        if greens == 9 {
            greens = 0
            greenNines += 1
        }
        
        greens += 1
        colourString = "G"
        returnInt = greens
    }
        
    else if current < fourAgo {
        if greens != 0 {greens = 0}
        
        if reds == 9 {
            reds = 0
            redNines += 1
        }
        
        reds += 1
        colourString = "R"
        returnInt = reds
    }
        
    else {greens = 0   ; colourString = ""}
    
    return (returnInt, colourString)
}

