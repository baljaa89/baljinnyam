

import UIKit
import Darwin
import CoreData

class Productivity2DMeasureInputController: UIViewController {
    

    @IBAction func nextDay(sender: AnyObject) {
        choosenDay = choosenDay.dateByAddingTimeInterval(24 * 60 * 60)
        choosenDayOn++
        loadDay()
    }
    
    @IBAction func previousDay(sender: AnyObject) {
        choosenDay = choosenDay.dateByAddingTimeInterval(-24 * 60 * 60)
        choosenDayOn--
        loadDay()
    }
    
    var choosenDayOn = 10000
    @IBOutlet weak var choosenDayLabel: UILabel!
    var index = 0
    var circle = UIView()
    var ind = true
    var choosenDay = NSDate()
    
    var pointX:CGFloat!
    var pointY:CGFloat!
     var calendar = Calendar()
    //MARK: - Life Cycle
    
    
    
    override func viewDidLoad() {
        setM_productivityData()
        super.viewDidLoad()
        var backButton = UIBarButtonItem(title: "キャンセル", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        loadDay()
        
    }
    
    
    func loadDay(){
        if ind {
            switch index {
            case 1:choosenDay = choosenDay.dateByAddingTimeInterval(-24*60*60)
            choosenDayOn--
            case 2:choosenDay = choosenDay.dateByAddingTimeInterval(-2*24*60*60)
            choosenDayOn-=2
            case 3:choosenDay = choosenDay.dateByAddingTimeInterval(-3*24*60*60)
            choosenDayOn-=3
            case 4:choosenDay = choosenDay.dateByAddingTimeInterval(-4*24*60*60)
            choosenDayOn-=4
            case 5:choosenDay = choosenDay.dateByAddingTimeInterval(-5*24*60*60)
            choosenDayOn-=5
            case 6:choosenDay = choosenDay.dateByAddingTimeInterval(-6*24*60*60)
            choosenDayOn-=6
            default: println(0)
            }
            ind = false
        }
        getT_productivityData()
        var x1:Float = 190.0
        var y1:Float = 390.0
        
        
        
        
        
        
        
        if choosenDayOn < 10000 {
            
            
            
            
            //   circle.alpha = 1.0
        }
        else {
            
        }
        
        let calendars = Calendar()
        
        choosenDayLabel.text = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Touch Event
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch:AnyObject in touches {
            var rank:String!
            let point = touch.locationInView(self.view)
            pointX = point.x
            pointY = point.y
            println("\(pointX) , \(pointY)")
            let center = self.view.center.x
            
         //
            if pointX > center-40 && pointX < center+40 && pointY < 360 && pointY > 280 {
                rank = "E"
                showToNext(rank)
            }
            else {
                if(pointX > center-120 && pointX < center+120 && pointY > 200 && pointY < 440) {
                if(pointX < center && pointY < 320) {
                    rank = "A"
                }
                if(pointX < center && pointY > 320) {
                    rank = "B"
                }
                if(pointX > center && pointY < 320) {
                    rank = "C"
                }
                if(pointX > center && pointY > 320) {
                    rank = "D"
                }
                    showToNext(rank)
                    
                }
                else
                {
                    println("seni")
                }
            }
        }
    }
    
    //MARK: - CoreData Fetch
    
    func getT_productivityData(){
        let request = NSFetchRequest(entityName: "T_productivity")
        
        var error: NSError? = nil
        let results:[T_productivity] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) as! [T_productivity]
        circle.removeFromSuperview()
        for t_productivity in results{
            
            if calendar.myYear(choosenDay) == calendar.myYear(t_productivity.dateTime) && calendar.myMonth(choosenDay) == calendar.myMonth(t_productivity.dateTime) && calendar.myDay(choosenDay) == calendar.myDay(t_productivity.dateTime){
                println(t_productivity.dateTime)
                println(choosenDay)
                var center = self.view.center.x-15
                center = center + CGFloat(t_productivity.achieve)
                var y = 305 + CGFloat(t_productivity.difficulty)
                circle.frame = CGRectMake(CGFloat(center), CGFloat(y), 30, 30)
                circle.layer.cornerRadius = 15.0
                circle.layer.borderColor = UIColor.greenColor().CGColor
                circle.layer.borderWidth = 2
                circle.clipsToBounds = true
                self.view.addSubview(circle)
            }
            
        }
    }
    
    
    func setM_productivityData(){
        let myEntity: NSEntityDescription! = NSEntityDescription.entityForName("M_productivity", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
        let m_productivity = M_productivity(entity: myEntity, insertIntoManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        m_productivity.horizontalminm = "残念感　やっちゃった"
        m_productivity.horizontalmaxm = "達成感　誰か褒めて"
        m_productivity.horizontal = "達成度"
        m_productivity.vertical = "難易度"
        m_productivity.horizontalmin = self.view.center.x-120
        m_productivity.horizontalmax = self.view.center.x+120
        m_productivity.verticalmin = 200
        m_productivity.verticalmax = 440
    }
    
    //MARK: - StoryBoard Segue
    
    func showToNext(rank:String){
        var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var productivityExaminationInputController = storyboard.instantiateViewControllerWithIdentifier("ProductivityExaminationInputController") as! ProductivityExaminationInputController
        productivityExaminationInputController.choosenDay = choosenDay
        productivityExaminationInputController.rank = rank
        productivityExaminationInputController.achieve = Int(pointX - self.view.center.x)
        productivityExaminationInputController.difficulty = Int(pointY - 320)
        self.navigationController?.pushViewController(productivityExaminationInputController, animated: true)
    }
}
