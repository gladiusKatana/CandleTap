/*🔥CandleTap💧VCs*/import UIKit

var cellGap = CGFloat(0) // if nonzero, do not make this smaller than: 0.5 (iphone7), or lines drawn inconsistently

var backgroundVC = UIViewController()

var topVC = CollectionVC(.initial, backgroundColour: UIColor.clear, colourIndex: nil,
                         collectionViewLayout: moneyManagementLayout) //= UIViewController()

var chartVC = ChartVC(.chart)

var pairListLayout = ///------------------------------------------------
    CustomFlowLayout(
        embeddedInNavController: true,
        customFrame: nil,
        rows: 8, cols: 4,
        lockedHeaderRows: 0, lockedHeaderSections: 0,
        cellWidth: nil, cellHeight: nil,
        autoFitWScale: 1, autoFitHScale: 1,
        hSpace: cellGap, vSpace: cellGap,
        loadsHorizontally: false,
        squareCellMode: .noAutoSquare)

var pairListVC = CollectionVC(.pairList, backgroundColour: defaultColour, colourIndex: 0, collectionViewLayout: pairListLayout)


var moneyManagementLayout = ///---------------------------------------------
    CustomFlowLayout(
        embeddedInNavController: true,          ///  if true, it's fullscreen (with a nav bar button to navigate to its collection view controller's view); else it's a window with a custom frame
        customFrame: globalWindow.frame,                       ///  if nil, defaults to a pre-set frame, the app's window frame (as described in above comment)
        rows: 20, cols: 4,
        lockedHeaderRows: 1, lockedHeaderSections: 0,
        cellWidth: nil, cellHeight: nil,        ///  if either parameter is nil, screen width and/or height is autofitted (else, auto-fit scalars below are ignored, ie set to 1.0)
        autoFitWScale: 1, autoFitHScale: 1,     ///  if either of these parameters are nil, they default to 1.0
        hSpace: cellGap, vSpace: cellGap,       ///  gaps between the cells
        loadsHorizontally: false,               ///❗️if loadsHorizontally is true, 'rows' look like columns
        squareCellMode: .noAutoSquare)

var moneyManagementVC = CollectionVC(.moneyManagement, backgroundColour: defaultColour, colourIndex: nil, collectionViewLayout: moneyManagementLayout)

