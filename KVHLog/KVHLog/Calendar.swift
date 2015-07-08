import UIKit
class Calendar: NSObject {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    func myYear(mydate: NSDate) -> Int{
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        let myComponetns = myCalendar.components(NSCalendarUnit.CalendarUnitYear   |
            
            NSCalendarUnit.CalendarUnitMonth  |
            
            NSCalendarUnit.CalendarUnitDay    |
            
            NSCalendarUnit.CalendarUnitHour   |
            
            NSCalendarUnit.CalendarUnitMinute |
            
            NSCalendarUnit.CalendarUnitSecond |
            
            NSCalendarUnit.CalendarUnitWeekday,
            
            fromDate: mydate)
        return myComponetns.year
    }
    func myWeekday(mydate: NSDate) -> Int{
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        let myComponetns = myCalendar.components(NSCalendarUnit.CalendarUnitYear   |
            
            NSCalendarUnit.CalendarUnitMonth  |
            
            NSCalendarUnit.CalendarUnitDay    |
            
            NSCalendarUnit.CalendarUnitHour   |
            
            NSCalendarUnit.CalendarUnitMinute |
            
            NSCalendarUnit.CalendarUnitSecond |
            
            NSCalendarUnit.CalendarUnitWeekday,
            
            fromDate: mydate)
        return myComponetns.weekday
    }
    func myMonth(mydate: NSDate) -> Int{
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        let myComponetns = myCalendar.components(NSCalendarUnit.CalendarUnitYear   |
            
            NSCalendarUnit.CalendarUnitMonth  |
            
            NSCalendarUnit.CalendarUnitDay    |
            
            NSCalendarUnit.CalendarUnitHour   |
            
            NSCalendarUnit.CalendarUnitMinute |
            
            NSCalendarUnit.CalendarUnitSecond |
            
            NSCalendarUnit.CalendarUnitWeekday,
            
            fromDate: mydate)
        return myComponetns.month
    }
    func myDay(mydate: NSDate) -> Int{
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        let myComponetns = myCalendar.components(NSCalendarUnit.CalendarUnitYear   |
            
            NSCalendarUnit.CalendarUnitMonth  |
            
            NSCalendarUnit.CalendarUnitDay    |
            
            NSCalendarUnit.CalendarUnitHour   |
            
            NSCalendarUnit.CalendarUnitMinute |
            
            NSCalendarUnit.CalendarUnitSecond |
            
            NSCalendarUnit.CalendarUnitWeekday,
            
            fromDate: mydate)
        return myComponetns.day
    }
    
    func myHour(mydate: NSDate) -> Int{
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        let myComponetns = myCalendar.components(NSCalendarUnit.CalendarUnitYear   |
            
            NSCalendarUnit.CalendarUnitMonth  |
            
            NSCalendarUnit.CalendarUnitDay    |
            
            NSCalendarUnit.CalendarUnitHour   |
            
            NSCalendarUnit.CalendarUnitMinute |
            
            NSCalendarUnit.CalendarUnitSecond |
            
            NSCalendarUnit.CalendarUnitWeekday,
            
            fromDate: mydate)
        return myComponetns.hour
    }
    
    
    func myMinute(mydate: NSDate) -> Int{
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        
        let myComponetns = myCalendar.components(NSCalendarUnit.CalendarUnitYear   |
            
            NSCalendarUnit.CalendarUnitMonth  |
            
            NSCalendarUnit.CalendarUnitDay    |
            
            NSCalendarUnit.CalendarUnitHour   |
            
            NSCalendarUnit.CalendarUnitMinute |
            
            NSCalendarUnit.CalendarUnitSecond |
            
            NSCalendarUnit.CalendarUnitWeekday,
            
            fromDate: mydate)
        return myComponetns.minute
    }
}
