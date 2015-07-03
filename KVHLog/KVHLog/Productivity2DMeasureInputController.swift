

import UIKit
import Darwin

class Productivity2DMeasureInputController: UIViewController {

    
    @IBAction func nextDay(sender: AnyObject) {
        choosenDay = choosenDay.dateByAddingTimeInterval(24 * 60 * 60)
        viewDidLoad()
    }
    
    @IBAction func previousDay(sender: AnyObject) {
        choosenDay = choosenDay.dateByAddingTimeInterval(-24 * 60 * 60)
        viewDidLoad()
    }
    
    
    @IBOutlet weak var choosenDayLabel: UILabel!
    var index = 0
    
    var choosenDay = NSDate()
    
    //MARK: - Life Cycle
    var ind = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var backButton = UIBarButtonItem(title: "キャンセル", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        if ind {
            switch index {
            case 1:choosenDay = choosenDay.dateByAddingTimeInterval(-24*60*60)
            case 2:choosenDay = choosenDay.dateByAddingTimeInterval(-2*24*60*60)
            case 3:choosenDay = choosenDay.dateByAddingTimeInterval(-3*24*60*60)
            case 4:choosenDay = choosenDay.dateByAddingTimeInterval(-4*24*60*60)
            case 5:choosenDay = choosenDay.dateByAddingTimeInterval(-5*24*60*60)
            case 6:choosenDay = choosenDay.dateByAddingTimeInterval(-6*24*60*60)
            default: println(0)
            }
            ind = false
        }
        
        
        
        let calendars = CalendarController()
        
        choosenDayLabel.text = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch:AnyObject in touches {
            let point = touch.locationInView(self.view)
            let pointX = point.x
            let pointY = point.y
            let a = (pointX-180)*(pointX-180) + (pointY-320)*(pointY-320)
            let radius = sqrt(a)
            if radius < 120 {
            println("\(pointX)   \(pointY)")
            }
        }
    }
}
