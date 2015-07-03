import UIKit

class WeeklyCourseCalendarController: UIViewController {
    
    
    
    
    
    
    
    
    @IBOutlet weak var day6Label: UILabel!
    
    @IBOutlet weak var day5Label: UILabel!
    
    @IBOutlet weak var day4Label: UILabel!
    
    @IBOutlet weak var day3Label: UILabel!
    
    @IBOutlet weak var day2Label: UILabel!
    
    @IBOutlet weak var day1Label: UILabel!
    
    @IBOutlet weak var day0Label: UILabel!
    
    
    
    
    
    
    
    @IBAction func nextWeekButton(sender: AnyObject) {
        myDate = myDate.dateByAddingTimeInterval(7*24 * 60 * 60)
        viewDidLoad()
    }
    
    @IBAction func previousWeekButton(sender: AnyObject) {
        myDate = myDate.dateByAddingTimeInterval(-7*24 * 60 * 60)
        viewDidLoad()
    }
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var productivityToday: UILabel!
    let productivity = Productivity.sharedInstance.productivityCalculator()
    
    
    
    
    
    @IBOutlet weak var choosenWeekLabel: UILabel!
    
    var weekBeginning = 1
    
    
    
    
    
    
    
    
    
    
    
    var myDate = NSDate()
    var myDateLast = NSDate()  //週の最後の日のデータ
    var day1 = NSDate()
    var day2 = NSDate()
    var day3 = NSDate()
    var day4 = NSDate()
    var day5 = NSDate()
    var day6 = NSDate()
    var day7 = NSDate()
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        productivityToday.text = "本日の生産性　\(productivity[10000])kvh"
        let calendars = CalendarController()
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
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "dailyCourseCalendar"  {
                let dailyCourseCalendar = segue.destinationViewController as! DailyCourseCalendarController
                
                var day0s = NSDate()
                day0s = day7.dateByAddingTimeInterval(24 * 60 * 60)
                switch sender!.tag{
                case 7: dailyCourseCalendar.choosenDay = day2
                case 6: dailyCourseCalendar.choosenDay = day3
                case 5: dailyCourseCalendar.choosenDay = day4
                case 4:
                    dailyCourseCalendar.choosenDay = day5
                case 3:
                    dailyCourseCalendar.choosenDay = day6
                case 2:
                    dailyCourseCalendar.choosenDay = day7
                case 1:
                    dailyCourseCalendar.choosenDay = day0s
                default: println(0)
                }
            
            
            
            
        }
    }
}
