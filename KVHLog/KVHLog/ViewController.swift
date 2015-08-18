import UIKit
import CoreData
class ViewController: UIViewController,UITabBarControllerDelegate {


    
    @IBAction func nextDay(sender: AnyObject) {
        choosenDayOk = choosenDayOk.dateByAddingTimeInterval(24 * 60 * 60)
        choosenDayOn++
        getMainContents()
    }
    @IBAction func previousDay(sender: AnyObject) {
        choosenDayOk = choosenDayOk.dateByAddingTimeInterval(-24 * 60 * 60)
        choosenDayOn--
        getMainContents()
    }
    
    @IBOutlet weak var choosenDayLabel: UILabel!
    @IBOutlet weak var choosenDayProductivity: UILabel!
    var calendar = Calendar()
    
    var choosenDayOn = 10000
    
    var choosenDayOk = NSDate()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rankArray:[String] = ["A","B","C","D","E"]
        let internetAPI = InternetAPI()
//        internetAPI.commondateAPI("productivity", userid:"shima", password: "passwd", date: "2015-07-22%2000:00:00", dateType: "dateInput")
//        internetAPI.commondateAPI("productivity", userid:"shima", password: "passwd", date: "2015-07-13%2009:00:00", dateType: "dateInput")
//        internetAPI.commondateAPI("inputratet", userid:"shima", password: "passwd", date: "201507", dateType: "month")
//        internetAPI.commonAPI("activitym", userid: "shima", password: "passwd")
//        internetAPI.m_listofvalAPI("FitbitIntegration", name: "1")
     // not used   internetAPI.m_listofvalAPI("FitbitIntegration")
      //  internetAPI.commondateAPI("productivitym", userid:"shima", password: "passwd", date: "2015-07-22%2000:00:00", dateType: "dateInput")
        for rank in rankArray{
            internetAPI.m_questionaireAPI(rank)
        }
   //     internetAPI.m_questionaireAPI("A")
//        internetAPI.commonAPI("profilem", userid: "shima", password: "passwd")
//        internetAPI.commonAPI("objective", userid: "shima", password: "passwd")
//        internetAPI.commonAPI("notificationm", userid: "shima", password: "passwd")
     //   internetAPI.commonAPI("userm", userid: "shima", password: "passwd")
//        internetAPI.commonAPI("dashboardm", userid: "shima", password: "passwd")
        getMainContents()
        
        
        
        var backButton = UIBarButtonItem(title: "戻る", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
    }
    
    func getMainContents(){
        choosenDayProductivity.text = "未知"
        getT_productivityData()
    //    let productivity = Productivity.sharedInstance.productivityCalculator()
        
        let calendars = Calendar()
        
        choosenDayLabel.text = "\(calendars.myYear(choosenDayOk))年\(calendars.myMonth(choosenDayOk))月\(calendars.myDay(choosenDayOk))日"
        
        
        
//        if choosenDayOn > 10000 {
//            choosenDayProductivity.text = "未知"
//        }else {
//            
//            //   choosenDayProductivity.text
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "weeklyCourseGraph"  {
            let weeklyCourseGraph = segue.destinationViewController as! WeeklyCourseGraphController
        }
        
        if segue.identifier == "dashBoardEdit" {
            let dashBoardEdit = segue.destinationViewController as! DashboardEditController
            dashBoardEdit.index = NSTimeInterval(choosenDayOn-10000)
//            dashBoardEdit.setEditing(true, animated: true)
        }
    }
    
    
    //MARK: - CoreData Fetch
    
    func getT_productivityData(){
        let request = NSFetchRequest(entityName: "T_productivity")
        var error: NSError? = nil
        let results:[T_productivity] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) as! [T_productivity]
        
        var choosenDay = choosenDayOk
        for t_productivity in results {
            if calendar.myYear(choosenDay) == calendar.myYear(t_productivity.dateTime) && calendar.myMonth(choosenDay) == calendar.myMonth(t_productivity.dateTime) && calendar.myDay(choosenDay) == calendar.myDay(t_productivity.dateTime){
                choosenDayProductivity.text = t_productivity.productivity.description + "kvh"
            }

        }
    }
}

