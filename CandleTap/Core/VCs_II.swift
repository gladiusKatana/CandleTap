/*🔥CandleTap_VCs_II💧*/import UIKit


let zeroFrame = CGRect(x: 0, y: 0, width: 0, height: 0) /// Initial value for testing


var pairActionLayout = ///--------------------------------------------
    CustomFlowLayout(
        embeddedInNavController: false,
        customFrame: nil,
        rows: 5, cols: 1, lockedHeaderRows: 1, lockedHeaderSections: 0,
        cellWidth: 80, cellHeight: 20,
        autoFitWScale: nil, autoFitHScale: nil,
        hSpace: cellGap, vSpace: cellGap,
        loadsHorizontally: false,
        squareCellMode: .noAutoSquare)

var pairActionVC = PopupMenuVC(.popupMenu, collectionViewLayout: pairActionLayout)
var pairActionSwitchView = PopupSwitchView()


var archiveLayout = ///--------------------------------------------------
    CustomFlowLayout(
        embeddedInNavController: true,
        customFrame: globalWindow.frame,
        rows: 1, cols: 3, lockedHeaderRows: 0, lockedHeaderSections: 0,
        cellWidth: nil, cellHeight: 20,
        autoFitWScale: 1, autoFitHScale: 1,
        hSpace: cellGap, vSpace: cellGap,
        loadsHorizontally: false,
        squareCellMode: .noAutoSquare)

var archiveVC = CollectionVC(.archive, backgroundColour: defaultColour, colourIndex: 1, collectionViewLayout: archiveLayout)

