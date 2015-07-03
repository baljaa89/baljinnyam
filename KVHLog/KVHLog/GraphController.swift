import UIKit
class GraphController: UIViewController {
    
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
    
    var todayDate = NSDate()
    let productivity = Productivity.sharedInstance.productivityCalculator()
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        for index in 0...6 {
            stepsCountWeek[index] = productivity[10000-index]
        }
        let calendars = CalendarController()
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
        
        
        productToday.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y1 = 294 - (stepsCountWeek[0]*252/30000)
        productToday.frame = CGRectMake(353, CGFloat(y1), 27, 252)
        if stepsCountWeek[0] < goalNumber {
            self.starToday.alpha = 0.0
        }
        
        product1.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y2 = 294 - (stepsCountWeek[1]*252/30000)
        product1.frame = CGRectMake(303, CGFloat(y2), 27, 252)
        if stepsCountWeek[1] < goalNumber {
            self.star1.alpha = 0.0
        }
        
        product2.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y3 = 294 - (stepsCountWeek[2]*252/30000)
        product2.frame = CGRectMake(253, CGFloat(y3), 27, 252)
        if stepsCountWeek[2] < goalNumber {
            self.star2.alpha = 0.0
        }
        
        product3.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y4 = 294 - (stepsCountWeek[3]*252/30000)
        product3.frame = CGRectMake(203, CGFloat(y4), 27, 252)
        if stepsCountWeek[3] < goalNumber {
            self.star3.alpha = 0.0
        }
        
        product4.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y5 = 294 - (stepsCountWeek[4]*252/30000)
        product4.frame = CGRectMake(153, CGFloat(y5), 27, 252)
        if stepsCountWeek[4] < goalNumber {
            self.star4.alpha = 0.0
        }
        
        product5.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y6 = 294 - (stepsCountWeek[5]*252/30000)
        product5.frame = CGRectMake(103, CGFloat(y6), 27, 252)
        if stepsCountWeek[5] < goalNumber {
            self.star5.alpha = 0.0
        }
        
        product6.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y7 = 294 - (stepsCountWeek[6]*252/30000)
        product6.frame = CGRectMake(53, CGFloat(y7), 27, 252)
        if stepsCountWeek[6] < goalNumber {
            self.star6.alpha = 0.0
        }
        
        
        
        
        goalLine.setTranslatesAutoresizingMaskIntoConstraints(true)
        let x1 = 294 - 252*goalNumber/30000
        goalLine.frame = CGRectMake(49,CGFloat(x1), 345, 1)
        
        
        
        
        goalLineLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        goalLineLabel.frame = CGRectMake(10,CGFloat(x1-7), 31, 21)
        let x2 = Int((goalNumber+500)/1000)
        goalLineLabel.text = "\(x2)K"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
