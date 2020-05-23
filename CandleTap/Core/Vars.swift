/*🔥CandleTap_Vars💧*/import UIKit

/// Note— triple-commented global vars (///) denote vars not currently used, but that could be/ may be/ sometimes are used (ie in testing, etc)

var globalWindow = UIWindow(frame: UIScreen.main.bounds)

var navController: UINavigationController? = UINavigationController()

var dismissPinch = UIPinchGestureRecognizer();  var nineSkipTap = UITapGestureRecognizer()

var emailComposer = EmailComposer();            ///var timerForShowingScrollIndicator: Timer?


var statusBarHeight = 0.0;                      var lastStatusBarHeight = 0.0;      var navBarHeight = 0.0
var launchWidth = 0.0;                          var launchHeight = 0.0
var frameWidth = 0.0;                           var frameHeight = 0.0

var xOffSet = CGFloat(0);                       var yOffset = CGFloat(0)

var lastTappedCoordinate = [-1,-1];             var chartCoordinates = [[1,2]] //[[1,1],[1,2]]

var popupMenuDisplayed = false;                 var globalSwitchBool = false
var justPinched = false                         //; var textFieldDisplayed = false
var tempRescalingBool = false                   //; var showConsoleLegend = true
///var firstBecameActive = false                    //; var rotatedFromResignActive = false
//var reloadedFromHourTickingOver = true


var defaultTimetableCellFont = UIFont.systemFont(ofSize: 12, weight: .regular) /// UIFont(name: "Helvetica Neue", size: 12)

var launchOrientation = "orientation at the moment of launch"                                           //* will change this to an enum at some point
var currentOrientation = "orientation (landscape or portrait) for prepare-layout logic"                 //* " "
var previousOrientation = "previous orientation (landscape or portrait) for prepare-layout logic"       //* " "
///var lastActiveOrientation = "orientation (landscape or portrait) before sending app to background"             //* " "
///var chartOrientation = ""; var previousChartOrientation = ""                                                   //* " "

///var loadSymbolLegend = "                                        💾 = view loaded"
///var appearSymbolLegend = "                                        🏞 = view appeared"  /// console legend
///var truncationTrail = "…";                      ///var averageLetterWidth = CGFloat(0)

var dateString = "global csv date string";      var fileName = "global csv file name"
var modelName = "device you're running on"
var phones = ["iPhone4", "iPhone 4s", "iPhone 5", "iPhone 5c", "iPhone 5s", "iPhone 6", "iPhone 6 Plus", "iPhone 6s", "iPhone 6s Plus", "iPhone 7", "iPhone 7 Plus", "iPhone SE", "iPhone 8", "iPhone 8 Plus", "iPhone X", "iPhone XS", "iPhone XS Max", "iPhone XR"]

