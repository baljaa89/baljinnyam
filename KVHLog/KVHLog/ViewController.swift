import UIKit
class ViewController: UIViewController,UITabBarControllerDelegate {

    //変数宣言
    
    
    
    
    
    
    
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
    
//    var productivity:[Int]!
    
    var choosenDayOn = 10000
    
    var choosenDayOk = NSDate()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //main
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("")
        
        var backButton = UIBarButtonItem(title: "戻る", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
//        var tabArray = self.tabBarController?.tabBar.items as NSArray!
//        var tabItem = tabArray.objectAtIndex(0) as! UITabBarItem
//        tabItem.image = UIImage(named: "a.png")
        
        
        let productivity = Productivity.sharedInstance.productivityCalculator()
        
        let calendars = CalendarController()
        
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
//            while index<7{
////                weeklyCourseGraph.stepsCountWeek[index] = productivity[10000-index]
//                weeklyCourseGraph.stepsCountWeek.append(productivity[10000-index])
//                index++
//            }
            
            
            
            
            
//            let graphController = segue.destinationViewController as! GraphController
//            var index1 = 0
//            while index<7{
//                graphController.stepsCountWeek[index1] = productivity[10000-index1]
//                index1++
//            }
        }
    }
    
}

