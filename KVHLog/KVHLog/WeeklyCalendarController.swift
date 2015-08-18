

import UIKit
import CoreData

protocol WeeklyCalendarDelegate{
    func returnSelectedDate(date:NSDate)
}

class WeeklyCalendarController: UIViewController {
    
    
    
    @IBOutlet weak var day0Label: UILabel!
    @IBOutlet weak var day1Label: UILabel!
    @IBOutlet weak var day2Label: UILabel!
    @IBOutlet weak var day3Label: UILabel!
    @IBOutlet weak var day4Label: UILabel!
    @IBOutlet weak var day5Label: UILabel!
    @IBOutlet weak var day6Label: UILabel!
    
    
    @IBOutlet weak var day0Button: UIButton!
    
    @IBOutlet weak var day1Button: UIButton!
    @IBOutlet weak var day2Button: UIButton!
    @IBOutlet weak var day3Button: UIButton!
    @IBOutlet weak var day4Button: UIButton!
    @IBOutlet weak var day5Button: UIButton!
    @IBOutlet weak var da6Button: UIButton!
    
    
    @IBOutlet weak var nextWeekOutletButton: UIButton!
    @IBOutlet weak var previousWeekOutletButton: UIButton!
    
    
    
    var today = 10000
    var delegate:WeeklyCalendarDelegate!
    
    
    var calendarStart = NSDate()
    var calendarEnd = NSDate()
    @IBOutlet weak var choosenWeekLabel: UILabel!
    
    //前の週のデータ(UIButton)を一度削除する
    func removeAllSubviews(parentView: UIView){
        calendarStart = NSDate()
        calendarEnd = NSDate()
        var subviews = parentView.subviews
        for subview in subviews {
            if let sub1 = subview as? UIButton {
                if sub1 != nextWeekOutletButton && sub1 != previousWeekOutletButton && sub1 != da6Button && sub1 != day5Button && sub1 != day4Button && sub1 != day3Button && sub1 != day2Button && sub1 != day1Button && sub1 != day0Button {
                sub1.removeFromSuperview()
                }
            }
        }
    }
    
    @IBAction func nextWeekButton(sender: AnyObject) {
        removeAllSubviews(self.view)
        drawTimeGraph(0,color:1)
        myDate = myDate.dateByAddingTimeInterval(7*24 * 60 * 60)
        load()
        getT_ActivityData()
        
        
    }
    
    @IBAction func previousWeekButton(sender: AnyObject) {
        removeAllSubviews(self.view)
        drawTimeGraph(0,color:1)
        myDate = myDate.dateByAddingTimeInterval(-7*24 * 60 * 60)
        load()
        getT_ActivityData()
    }
    

    @IBOutlet weak var productivityToday: UILabel!
    let productivity = Productivity.sharedInstance.productivityCalculator()
    
    
    
    
    
    
    @IBAction func backToDaily(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    
    
    var weekBeginning = 2
    
    var myDate = NSDate()
    var myDateLast = NSDate()  //週の最後の日のデータ
    var day1 = NSDate()
    var day2 = NSDate()
    var day3 = NSDate()
    var day4 = NSDate()
    var day5 = NSDate()
    var day6 = NSDate()
    var day7 = NSDate()
    var buttonDay:UIButton!
    
    override func viewDidLoad() {
        
        
        drawTimeGraph(0,color:1)
        getM_profileData()
        load()
        getT_ActivityData()
        
//        calendarStart = calendarStart.dateByAddingTimeInterval(0*60 * 60)
//        calendarEnd = calendarEnd.dateByAddingTimeInterval(6*60 * 60)
        
        super.viewDidLoad()
        
      //  drawTimeGraph()
        
    }
    
    
    
    
    func drawTimeGraph(x:Int, color:Int){
        da6Button.setTranslatesAutoresizingMaskIntoConstraints(true)
        day0Button.setTranslatesAutoresizingMaskIntoConstraints(true)
        day1Button.setTranslatesAutoresizingMaskIntoConstraints(true)
        day2Button.setTranslatesAutoresizingMaskIntoConstraints(true)
        day3Button.setTranslatesAutoresizingMaskIntoConstraints(true)
        day4Button.setTranslatesAutoresizingMaskIntoConstraints(true)
        day5Button.setTranslatesAutoresizingMaskIntoConstraints(true)
        day0Label.setTranslatesAutoresizingMaskIntoConstraints(true)
        day1Label.setTranslatesAutoresizingMaskIntoConstraints(true)
        day2Label.setTranslatesAutoresizingMaskIntoConstraints(true)
        day3Label.setTranslatesAutoresizingMaskIntoConstraints(true)
        day4Label.setTranslatesAutoresizingMaskIntoConstraints(true)
        day5Label.setTranslatesAutoresizingMaskIntoConstraints(true)
        day6Label.setTranslatesAutoresizingMaskIntoConstraints(true)
        
        buttonDay = UIButton()
        
        
        switch self.view.frame.size.width {
        case 320:
            iphone5s()
        case 375:
            iphone6()
        case 414:
            iphone6plus()
            
        default:println()
        }
         let calendar = Calendar()
        
        let hourStart   = Float(calendar.myHour(calendarStart))
        let minuteStart = Float(calendar.myMinute(calendarStart))
        let hourEnd     = Float(calendar.myHour(calendarEnd))
        let minuteEnd   = Float(calendar.myMinute(calendarEnd))
        
        
        buttonDay.setTranslatesAutoresizingMaskIntoConstraints(true)
        
        
        
        switch self.view.frame.size.width {
        case 320:
            let x1 = CGFloat(25+40*(x-1))
            let y1 = CGFloat(151+(285*(hourStart+minuteStart/60)/24))
            let y2 = CGFloat(285*(hourEnd+minuteEnd-hourStart-minuteStart)/24)
            buttonDay.frame = CGRectMake(x1, y1, 30, y2)
            
        case 375:
            let x1 = CGFloat(30+46*(x-1))
            let y1 = CGFloat(165+(365*(hourStart+minuteStart/60)/24))
            let y2 = CGFloat(365*(hourEnd+minuteEnd-hourStart-minuteStart)/24)
            buttonDay.frame = CGRectMake(x1, y1, 35, y2)
        case 414:
            let x1 = CGFloat(36+51*(x-1))
            let y1 = CGFloat(173+(425*(hourStart+minuteStart/60)/24))
            let y2 = CGFloat(425*(hourEnd+minuteEnd-hourStart-minuteStart)/24)
            buttonDay.frame = CGRectMake(x1, y1, 30, y2)
        default:println()
        }
        buttonDay.layer.masksToBounds = true
        buttonDay.layer.cornerRadius = 8.0
        
      //  buttonDay.backgroundColor = UIColor.redColor()
        getSelectedColor(color)
       
        let days = [day1,day2,day3,day4,day5,day6,day7]
        var x = 0
        for day in days{
            x++
            if calendar.myDay(calendarStart) == calendar.myDay(day) && calendar.myMonth(calendarStart) == calendar.myMonth(day) && calendar.myYear(calendarStart) == calendar.myYear(day){
                
                
                
                switch x {
                case 1:
                    buttonDay.addTarget(self, action: "day6Button:", forControlEvents: UIControlEvents.TouchUpInside)
                    
                case 2:
                    buttonDay.addTarget(self, action: "day5Button:", forControlEvents: UIControlEvents.TouchUpInside)
                case 3:
                    buttonDay.addTarget(self, action: "day4Button:", forControlEvents: UIControlEvents.TouchUpInside)
                case 4:
                    buttonDay.addTarget(self, action: "day3Button:", forControlEvents: UIControlEvents.TouchUpInside)
                case 5:
                    buttonDay.addTarget(self, action: "day2Button:", forControlEvents: UIControlEvents.TouchUpInside)
                case 6:
                    buttonDay.addTarget(self, action: "day1Button:", forControlEvents: UIControlEvents.TouchUpInside)
                case 7:
                    buttonDay.addTarget(self, action: "day0Button:", forControlEvents: UIControlEvents.TouchUpInside)
                default: println()
                    
                }
                self.view.addSubview(buttonDay)
            }
        }
        
    }
    
    
    func iphone5s(){
        da6Button.frame = CGRectMake(25, 155, 30, 285)
        day5Button.frame = CGRectMake(65, 155, 30, 285)
        day4Button.frame = CGRectMake(105, 155, 30, 285)
        day3Button.frame = CGRectMake(145, 155, 30, 285)
        day2Button.frame = CGRectMake(185, 155, 30, 285)
        day1Button.frame = CGRectMake(225, 155, 30, 285)
        day0Button.frame = CGRectMake(265, 155, 30, 285)
        
        day6Label.frame = CGRectMake(27, 130, 28, 20)
        day5Label.frame = CGRectMake(67, 130, 28, 20)
        day4Label.frame = CGRectMake(107, 130, 28, 20)
        day3Label.frame = CGRectMake(147, 130, 28, 20)
        day2Label.frame = CGRectMake(187, 130, 28, 20)
        day1Label.frame = CGRectMake(227, 130, 28, 20)
        day0Label.frame = CGRectMake(267, 130, 28, 20)
       
    }
    
    func iphone6(){
        da6Button.frame = CGRectMake(30, 165, 35, 365)
        day5Button.frame = CGRectMake(76, 165, 35, 365)
        day4Button.frame = CGRectMake(122, 165, 35, 365)
        day3Button.frame = CGRectMake(168, 165, 35, 365)
        day2Button.frame = CGRectMake(214, 165, 35, 365)
        day1Button.frame = CGRectMake(260, 165, 35, 365)
        day0Button.frame = CGRectMake(306, 165, 35, 365)
        
        day6Label.frame = CGRectMake(33, 136, 28, 20)
        day5Label.frame = CGRectMake(79, 136, 28, 20)
        day4Label.frame = CGRectMake(125, 136, 28, 20)
        day3Label.frame = CGRectMake(171, 136, 28, 20)
        day2Label.frame = CGRectMake(217, 136, 28, 20)
        day1Label.frame = CGRectMake(263, 136, 28, 20)
        day0Label.frame = CGRectMake(309, 136, 28, 20)
        
    }
    
    func iphone6plus(){
        da6Button.frame = CGRectMake(36, 173, 33, 425)
        day5Button.frame = CGRectMake(87, 173, 33, 425)
        day4Button.frame = CGRectMake(138, 173, 33, 425)
        day3Button.frame = CGRectMake(189, 173, 33, 425)
        day2Button.frame = CGRectMake(240, 173, 33, 425)
        day1Button.frame = CGRectMake(291, 173, 33, 425)
        day0Button.frame = CGRectMake(342, 173, 33, 425)
        
        day6Label.frame = CGRectMake(40, 142, 28, 20)
        day5Label.frame = CGRectMake(90, 142, 28, 20)
        day4Label.frame = CGRectMake(140, 142, 28, 20)
        day3Label.frame = CGRectMake(190, 142, 28, 20)
        day2Label.frame = CGRectMake(240, 142, 28, 20)
        day1Label.frame = CGRectMake(290, 142, 28, 20)
        day0Label.frame = CGRectMake(340, 142, 28, 20)
        
    }
    
    
    
    func load() {
        getT_productivityData()
        productivityToday.text = "本日の生産性　\(today)kvh"
        let calendars = Calendar()
        switch weekBeginning {
        case calendars.myWeekday(myDate):
            day1 = myDate
            day2 = myDate.dateByAddingTimeInterval(24 * 60 * 60)
            day3 = myDate.dateByAddingTimeInterval(2*24 * 60 * 60)
            day4 = myDate.dateByAddingTimeInterval(3*24 * 60 * 60)
            day5 = myDate.dateByAddingTimeInterval(4*24 * 60 * 60)
            day6 = myDate.dateByAddingTimeInterval(5*24 * 60 * 60)
            day7 = myDate.dateByAddingTimeInterval(6*24 * 60 * 60)
        case calendars.myWeekday(myDate)-1:
            day1 = myDate.dateByAddingTimeInterval(-24 * 60 * 60)
            day2 = myDate
            day3 = myDate.dateByAddingTimeInterval(24 * 60 * 60)
            day4 = myDate.dateByAddingTimeInterval(2*24 * 60 * 60)
            day5 = myDate.dateByAddingTimeInterval(3*24 * 60 * 60)
            day6 = myDate.dateByAddingTimeInterval(4*24 * 60 * 60)
            day7 = myDate.dateByAddingTimeInterval(5*24 * 60 * 60)
            
        case calendars.myWeekday(myDate)-2:
            day1 = myDate.dateByAddingTimeInterval(-2*24 * 60 * 60)
            day2 = myDate.dateByAddingTimeInterval(-24 * 60 * 60)
            day3 = myDate
            day4 = myDate.dateByAddingTimeInterval(24 * 60 * 60)
            day5 = myDate.dateByAddingTimeInterval(2*24 * 60 * 60)
            day6 = myDate.dateByAddingTimeInterval(3*24 * 60 * 60)
            day7 = myDate.dateByAddingTimeInterval(4*24 * 60 * 60)
            
        case calendars.myWeekday(myDate)-3:
            day1 = myDate.dateByAddingTimeInterval(-3*24 * 60 * 60)
            day2 = myDate.dateByAddingTimeInterval(-2*24 * 60 * 60)
            day3 = myDate.dateByAddingTimeInterval(-24 * 60 * 60)
            day4 = myDate
            day5 = myDate.dateByAddingTimeInterval(24 * 60 * 60)
            day6 = myDate.dateByAddingTimeInterval(2*24 * 60 * 60)
            day7 = myDate.dateByAddingTimeInterval(3*24 * 60 * 60)
            
        case calendars.myWeekday(myDate)-4:
            day1 = myDate.dateByAddingTimeInterval(-4*24 * 60 * 60)
            day2 = myDate.dateByAddingTimeInterval(-3*24 * 60 * 60)
            day3 = myDate.dateByAddingTimeInterval(-2*24 * 60 * 60)
            day4 = myDate.dateByAddingTimeInterval(-24 * 60 * 60)
            day5 = myDate
            day6 = myDate.dateByAddingTimeInterval(24 * 60 * 60)
            day7 = myDate.dateByAddingTimeInterval(2*24 * 60 * 60)
            
        case calendars.myWeekday(myDate)-5:
            day1 = myDate.dateByAddingTimeInterval(-5*24 * 60 * 60)
            day2 = myDate.dateByAddingTimeInterval(-4*24 * 60 * 60)
            day3 = myDate.dateByAddingTimeInterval(-3*24 * 60 * 60)
            day4 = myDate.dateByAddingTimeInterval(-2*24 * 60 * 60)
            day5 = myDate.dateByAddingTimeInterval(-24 * 60 * 60)
            day6 = myDate
            day7 = myDate.dateByAddingTimeInterval(24 * 60 * 60)
            
        case calendars.myWeekday(myDate)-6:
            day1 = myDate.dateByAddingTimeInterval(-6*24 * 60 * 60)
            day2 = myDate.dateByAddingTimeInterval(-5*24 * 60 * 60)
            day3 = myDate.dateByAddingTimeInterval(-4*24 * 60 * 60)
            day4 = myDate.dateByAddingTimeInterval(-3*24 * 60 * 60)
            day5 = myDate.dateByAddingTimeInterval(-2*24 * 60 * 60)
            day6 = myDate.dateByAddingTimeInterval(-24 * 60 * 60)
            day7 = myDate
            
            
            
        default : println(1)
        }
        
        
        
        
        choosenWeekLabel.text = "      \(calendars.myYear(day1)) / \(calendars.myMonth(day1)) / \(calendars.myDay(day1)) - \(calendars.myMonth(day7)) / \(calendars.myDay(day7))"
        day6Label.text = "\(calendars.myDay(day1))日"
        day5Label.text = "\(calendars.myDay(day2))日"
        day4Label.text = "\(calendars.myDay(day3))日"
        day3Label.text = "\(calendars.myDay(day4))日"
        day2Label.text = "\(calendars.myDay(day5))日"
        day1Label.text = "\(calendars.myDay(day6))日"
        day0Label.text = "\(calendars.myDay(day7))日"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func day0Button(sender: AnyObject) {

        self.delegate?.returnSelectedDate(day7)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func day1Button(sender: AnyObject) {
        self.delegate?.returnSelectedDate(day6)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func day2Button(sender: AnyObject) {
        self.delegate?.returnSelectedDate(day5)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func day3Button(sender: AnyObject) {
        self.delegate?.returnSelectedDate(day4)
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func day4Button(sender: AnyObject) {
        self.delegate?.returnSelectedDate(day3)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func day5Button(sender: AnyObject) {
        self.delegate?.returnSelectedDate(day2)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func day6Button(sender: AnyObject) {
        self.delegate?.returnSelectedDate(day1)
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    //MARK: - CoreData Fetch
    
    func getT_ActivityData(){
        let request = NSFetchRequest(entityName: "T_activity")
        var error: NSError? = nil
        let results: [T_activity] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error)! as! [T_activity]
        
        
        let request1 = NSFetchRequest(entityName: "M_activity")
        let results1: [M_activity] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request1, error: &error)! as! [M_activity]
        
        var calendar = Calendar()
        var choosenDay = day1
        for var i = 0;i<7;++i {
            for t_activity in results {
                if calendar.myYear(choosenDay) == calendar.myYear(t_activity.starttime) && calendar.myMonth(choosenDay) == calendar.myMonth(t_activity.starttime) && calendar.myDay(choosenDay) == calendar.myDay(t_activity.starttime){
                    var color = 1
                    for m_activity in results1 {
                        if m_activity.activity == t_activity.activity {
                            color = m_activity.color.integerValue
                        }
                    }
//
                    calendarStart = t_activity.starttime
              //      println("time is \(calendarStart)")
                    calendarEnd = t_activity.endtime
                    
                    drawTimeGraph(i+1,color:color)
                    
                }
                
            
            }
           choosenDay = choosenDay.dateByAddingTimeInterval(24*60*60)
        }
    }
    
    func getSelectedColor(i:Int) {
        switch i{
        case 0:  buttonDay.backgroundColor = UIColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        case 1:buttonDay.backgroundColor = UIColor.redColor()
        case 2:buttonDay.backgroundColor = UIColor.blueColor()
        case 3:buttonDay.backgroundColor = UIColor.grayColor()
        case 4:buttonDay.backgroundColor = UIColor.lightGrayColor()
        case 5:buttonDay.backgroundColor = UIColor.greenColor()
        case 6:buttonDay.backgroundColor = UIColor.orangeColor()
        case 7:buttonDay.backgroundColor = UIColor.yellowColor()
        case 8:buttonDay.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.2, alpha: 1.0)
        case 9:buttonDay.backgroundColor = UIColor(red: 0.3, green: 0.2, blue: 0.2, alpha: 1.0)
        case 10:buttonDay.backgroundColor = UIColor(red: 0.5, green: 0.2, blue: 0.2, alpha: 1.0)
        case 11:buttonDay.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 1.0)
        case 12:buttonDay.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
        case 13:buttonDay.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.2, alpha: 1.0)
        case 14:buttonDay.backgroundColor = UIColor(red: 0.3, green: 0.4, blue: 0.2, alpha: 1.0)
        case 15:buttonDay.backgroundColor = UIColor(red: 0.7, green: 0.4, blue: 0.2, alpha: 1.0)
        case 16:buttonDay.backgroundColor = UIColor(red: 0.9, green: 0.4, blue: 0.2, alpha: 1.0)
        case 17:buttonDay.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.6, alpha: 1.0)
        case 18:buttonDay.backgroundColor = UIColor(red: 0.3, green: 0.4, blue: 0.6, alpha: 1.0)
        case 19:buttonDay.backgroundColor = UIColor(red: 0.5, green: 0.4, blue: 0.6, alpha: 1.0)
        case 20:buttonDay.backgroundColor = UIColor(red: 0.7, green: 0.4, blue: 0.6, alpha: 1.0)
        case 21:buttonDay.backgroundColor = UIColor(red: 0.9, green: 0.4, blue: 0.6, alpha: 1.0)
        case 22:buttonDay.backgroundColor = UIColor(red: 0.1, green: 0.8, blue: 0.6, alpha: 1.0)
        case 23:buttonDay.backgroundColor = UIColor(red: 0.5, green: 0.8, blue: 0.6, alpha: 1.0)
            
        default: println(0)
        }
    }
    
    func getM_profileData(){
        let request = NSFetchRequest(entityName: "M_notification")
        var error: NSError? = nil
        let results: NSArray = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        
        
        for item in results {
            var m_notification = item as! M_notification
            
            if CoreDataManager.sharedInstance.managedObjectContext!.countForFetchRequest(request, error: &error) > 0{
                weekBeginning = m_notification.weekstart.integerValue
                println("time is \(weekBeginning)")
                
            }
        }
    }
    
    
    
    
    
    func getT_productivityData(){
        let request = NSFetchRequest(entityName: "T_productivity")
        var error: NSError? = nil
        let results:[T_productivity] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) as! [T_productivity]
        var calendar = Calendar()
        
        
            var choosenDay = NSDate()
            for t_productivity in results {
                if calendar.myYear(choosenDay) == calendar.myYear(t_productivity.dateTime) && calendar.myMonth(choosenDay) == calendar.myMonth(t_productivity.dateTime) && calendar.myDay(choosenDay) == calendar.myDay(t_productivity.dateTime){
                    today = t_productivity.productivity.integerValue
                }
            }
    }

}
