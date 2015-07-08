

import UIKit

class GraphController1: UIViewController {

    var goalNumber = 21000
    @IBOutlet weak var goalLine: UIView!
    @IBOutlet weak var goalLineLabel: UILabel!
    
    @IBOutlet weak var today: UILabel!
    
    @IBOutlet weak var weekDays: UILabel!
    
    @IBOutlet weak var productToday: UIView!
    @IBOutlet weak var product1: UIView!
    @IBOutlet weak var product2: UIView!
    @IBOutlet weak var product3: UIView!
    @IBOutlet weak var product4: UIView!
    @IBOutlet weak var product5: UIView!
    @IBOutlet weak var product6: UIView!
    var stepsCountWeek:[Int] = [19004,10670,3400,10000,22000,24560,29320]
    
    @IBOutlet weak var starToday: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star6: UIImageView!
    
  
    
    @IBOutlet weak var halfView: UIView!
    @IBOutlet weak var fullView: UIView!
    
    @IBOutlet weak var halfLabel: UILabel!
    @IBOutlet weak var fullLabel: UILabel!
    @IBOutlet weak var zeroLabel: UILabel!
    
    
    var todayDate = NSDate()
    let productivity = Productivity.sharedInstance.productivityCalculator()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        for index in 0...6 {
            stepsCountWeek[index] = productivity[10000-index]
        }
        let calendars = Calendar()
        switch calendars.myWeekday(todayDate) {
        case 1:weekDays.text = "月　　火　　水　　木　　金　　土"
        today.text = "日"
        case 2:weekDays.text = "火　　水　　木　　金　　土　　日"
        today.text = "月"
        case 3:weekDays.text = "水　　木　　金　　土　　日　　月"
        today.text = "火"
        case 4:weekDays.text = "木　　金　　土　　日　　月　　火"
        today.text = "水"
        case 5:weekDays.text = "金　　土　　日　　月　　火　　水"
        today.text = "木"
        case 6:weekDays.text = "土　　日　　月　　火　　水　　木"
        today.text = "金"
        case 7:weekDays.text = "日　　月　　火　　水　　木　　金"
        today.text = "土"
        default: println(0)
        }
        
        var first = 238
        
        var width = 27
        var ww = 50
        var ws = 272
        var wx = 357
        switch self.view.frame.size.width {
        case 320:
            first = 238
            width = 22
            ww = 38
            ws = 215
            wx = 285
            weekDays.font = UIFont.systemFontOfSize(13)
        case 375:
            first = 238
            width = 25
            ww = 47
            ws = 260
            wx = 339
            weekDays.font = UIFont.systemFontOfSize(16)
        default:println()
        }
        
        var length = first-42
        
        
        weekDays.setTranslatesAutoresizingMaskIntoConstraints(true)
        today.setTranslatesAutoresizingMaskIntoConstraints(true)
        today.frame = CGRectMake(CGFloat(wx), 7, 17, 21)
        weekDays.frame = CGRectMake(57, 7, CGFloat(ws), 21)
        
        productToday.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y1 = first - (stepsCountWeek[0]*length/30000)
        productToday.frame = CGRectMake(CGFloat(53+6*ww), CGFloat(y1), CGFloat(width), CGFloat(first-y1))
        if stepsCountWeek[0] < goalNumber {
            self.starToday.alpha = 0.0
        }
        
        product1.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y2 = first - (stepsCountWeek[1]*length/30000)
        product1.frame = CGRectMake(CGFloat(53+5*ww), CGFloat(y2), CGFloat(width), CGFloat(stepsCountWeek[1]*length/30000))
        if stepsCountWeek[1] < goalNumber {
            self.star1.alpha = 0.0
        }
        
        product2.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y3 = first - (stepsCountWeek[2]*length/30000)
        product2.frame = CGRectMake(CGFloat(53+4*ww), CGFloat(y3), CGFloat(width), CGFloat(stepsCountWeek[2]*length/30000))
        if stepsCountWeek[2] < goalNumber {
            self.star2.alpha = 0.0
        }
        
        product3.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y4 = first - (stepsCountWeek[3]*length/30000)
        product3.frame = CGRectMake(CGFloat(53+3*ww), CGFloat(y4), CGFloat(width), CGFloat(stepsCountWeek[3]*length/30000))
        if stepsCountWeek[3] < goalNumber {
            self.star3.alpha = 0.0
        }
        
        product4.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y5 = first - (stepsCountWeek[4]*length/30000)
        product4.frame = CGRectMake(CGFloat(53+2*ww), CGFloat(y5), CGFloat(width), CGFloat(stepsCountWeek[4]*length/30000))
        if stepsCountWeek[4] < goalNumber {
            self.star4.alpha = 0.0
        }
        
        product5.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y6 = first - (stepsCountWeek[5]*length/30000)
        product5.frame = CGRectMake(CGFloat(53+ww), CGFloat(y6), CGFloat(width), CGFloat(stepsCountWeek[5]*length/30000))
        if stepsCountWeek[5] < goalNumber {
            self.star5.alpha = 0.0
        }
        
        product6.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y7 = first - (stepsCountWeek[6]*length/30000)
        product6.frame = CGRectMake(53, CGFloat(y7), CGFloat(width), CGFloat(stepsCountWeek[6]*length/30000))
        if stepsCountWeek[6] < goalNumber {
            self.star6.alpha = 0.0
        }
        
        
        
        
        
        
        goalLine.setTranslatesAutoresizingMaskIntoConstraints(true)
        let x1 = first - length*goalNumber/30000
        goalLine.frame = CGRectMake(49,CGFloat(x1), 345, 1)
        
        halfView.setTranslatesAutoresizingMaskIntoConstraints(true)
        halfView.frame = CGRectMake(49, CGFloat(21+(first/2)), 345, 1)
        
        
        
        
        
        
        
        goalLineLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        goalLineLabel.frame = CGRectMake(10,CGFloat(x1-9), 31, 21)
        let x2 = Int((goalNumber+500)/1000)
        goalLineLabel.text = "\(x2)K"
        
        halfLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        halfLabel.frame = CGRectMake(10,CGFloat(first/2+12), 31, 21)
        
        zeroLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        zeroLabel.frame = CGRectMake(10,CGFloat(first-18), 31, 21)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
