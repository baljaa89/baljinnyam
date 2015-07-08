import UIKit
class ViewController: UIViewController,UITabBarControllerDelegate {


    
    @IBAction func nextDay(sender: AnyObject) {
        choosenDayOk = choosenDayOk.dateByAddingTimeInterval(24 * 60 * 60)
        choosenDayOn++
        viewDidLoad()
    }
    @IBAction func previousDay(sender: AnyObject) {
        choosenDayOk = choosenDayOk.dateByAddingTimeInterval(-24 * 60 * 60)
        choosenDayOn--
        viewDidLoad()
    }
    
    @IBOutlet weak var choosenDayLabel: UILabel!
    @IBOutlet weak var choosenDayProductivity: UILabel!
    
    var choosenDayOn = 10000
    
    var choosenDayOk = NSDate()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("")
        
        var backButton = UIBarButtonItem(title: "戻る", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        
        let productivity = Productivity.sharedInstance.productivityCalculator()
        
        let calendars = Calendar()
        
        choosenDayLabel.text = "\(calendars.myYear(choosenDayOk))年\(calendars.myMonth(choosenDayOk))月\(calendars.myDay(choosenDayOk))日"
        
        
        
        if choosenDayOn > 10000 {
            choosenDayProductivity.text = "未知"
        }else {
            
            choosenDayProductivity.text = "\(productivity[choosenDayOn])kvh"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "weeklyCourseGraph"  {
            
            let weeklyCourseGraph = segue.destinationViewController as! WeeklyCourseGraphController
            var index = 0
        }
        
        if segue.identifier == "dashBoardEdit" {
            let dashBoardEdit = segue.destinationViewController as! DashboardEditController
            dashBoardEdit.index = NSTimeInterval(choosenDayOn-10000)
        }
    }
}

