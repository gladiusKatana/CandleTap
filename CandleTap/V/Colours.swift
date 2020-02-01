/*🔥CandleTap_Colours💧*/import UIKit


var defaultColour = platinum;

var defaultButtonColour = platinum;                 var defaultGreyoutColour = grayTwo

var cellDefaultColour = platinum;                   var defaultSwitchColour = platinum

var defaultTextColour = UIColor.black;              var headerColour = UIColor.darkGray


var xcodeDuskBackground = UIColor.rgb(30, g: 32, b: 40, a: 1)

var platinum = UIColor.rgb(214, g: 214, b: 214, a: 1);              var platinumLite = UIColor.rgb(214, g: 214, b: 255, a: 0.25)


var iosSettingsGray = UIColor.rgb(240, g: 240, b: 247, a: 1);       var popupMenuLightGray = UIColor.lightGray
var graySeven = UIColor.rgb(0, g: 0, b: 0, a: 0.7)
var grayBarelyThere = UIColor.rgb(0, g: 0, b: 0, a: 0.03);          var grayTwo = UIColor.rgb(0, g: 0, b: 0, a: 0.2)

var jadeGreen = UIColor.rgb(22, g: 134, b: 79, a: 1)                ///var jadeGreenLight = UIColor.rgb(60, g: 120, b: 79, a: 0.3);

///var navyBlue = UIColor.rgb(0, g: 50, b: 96, a: 1);                                                                   var darkNavy = UIColor.rgb(0, g: 36, b: 82, a: 1)
///var extraLightNavy = UIColor.rgb(0, g: 56, b: 116, a: 0.4);                                                     var taskTextBlue = UIColor.rgb(50, g: 50, b: 250, a: 1)

var randomColours =     // used in TestSquare.swift
    [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor, UIColor.purple.cgColor, UIColor.white.cgColor]

var darkModeOn = true

func setColoursFromSettings() {
    if darkModeOn {
        defaultColour               = xcodeDuskBackground
        cellDefaultColour           = xcodeDuskBackground
        defaultTextColour           = platinum
        defaultButtonColour         = platinum
        defaultGreyoutColour        = platinumLite
    } else {
        defaultColour               = platinum
        cellDefaultColour           = platinum
        defaultTextColour           = xcodeDuskBackground
        defaultButtonColour         = xcodeDuskBackground
        defaultGreyoutColour        = grayTwo
    }
}

extension UIColor {
    static func rgb(_ r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

