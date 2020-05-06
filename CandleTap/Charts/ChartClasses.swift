/*🔥CandleTap_ChartClasses💧*/import UIKit

class Bar: UIView {
    
    var dataBar: CGRect = {
        let bar = CGRect()
        return bar
    }()
    
//    var rectangleView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .clear
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    override init(frame: CGRect) {                                          //print("   (override init  bar graph view)")
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ChartRectangle: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear//defaultGreyoutColour
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ frame: CGRect) {
        let color:UIColor = platinumLite //platinum
        
        let drect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height) ///CGRect(x: (w * 0.25), y: (h * 0.25), width: (w * 0.5), height: (h * 0.5))
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        
        color.set()
        bpath.stroke()
        
        //print("it ran")
        NSLog("drawRect has updated the view")
    }
}

