

import UIKit
import CoreData

class WeeklyCourseExaminationController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var thisWeekLabel: UILabel!
    var week:[String] = ["今日","木","水","火","月","日","土"]
    var today = NSDate()
    let productivity = Productivity.sharedInstance.productivityCalculator()
    var examination:[String] = []
  //  var examination:[String] = ["","","","","","",""]
    var stepsCountWeek:[Int] = [0,0,0,0,0,0,0]
    var examinationPoint:[String] = []
    var calendar = Calendar()
    var index:[Int] = [0,1,2,3,4,5,6,100]
    //MARK: - CoreData Fetch
    
    func getT_productivityData(){
        let request = NSFetchRequest(entityName: "T_productivity")
        var error: NSError? = nil
        let results:[T_productivity] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) as! [T_productivity]
        
        var j = 0
        var ts = 0
        var xt = 0
        for var i:Int = 0;i<7; i++ {
            index[i] = ts
            var choosenDay = NSDate()
            choosenDay = choosenDay.dateByAddingTimeInterval(NSTimeInterval(-i * 24 * 60 * 60))
            for t_productivity in results {
                
                
                if calendar.myYear(choosenDay) == calendar.myYear(t_productivity.dateTime) && calendar.myMonth(choosenDay) == calendar.myMonth(t_productivity.dateTime) && calendar.myDay(choosenDay) == calendar.myDay(t_productivity.dateTime){
                    xt = 1
                    let measureArray = t_productivity.measure.componentsSeparatedByString(",")
                   
                    var t = 0
                    for count in measureArray{
                        
                        t++
                        examination.append(count)
                        if t < 2
                        {
                            examinationPoint.append(t_productivity.rank)
                        }
                       
                        if t > 1 {
                            j++
                            week.insert("", atIndex: j)
                            ts++
                             examinationPoint.append("")
                        }
                        }
                    ts++
                    stepsCountWeek[i] = t_productivity.productivity.integerValue
                     j++
                }
            }
            if xt == 0 {
                ts++
                j++
                examination.append("")
                examinationPoint.append("")
            }
            xt = 0
        }
        
        println(index)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var backButton = UIBarButtonItem(title: "戻る", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        makeWeekDay()
        getT_productivityData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StepsCountCell", forIndexPath: indexPath) as! UITableViewCell
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func makeWeekDay(){
        var calendars = Calendar()
        switch calendars.myWeekday(today) {
        case 1: week[1] = "土"
        week[2] = "金"
        week[3] = "木"
        week[4] = "水"
        week[5] = "火"
        week[6] = "月"
        case 2: week[1] = "日"
        week[2] = "土"
        week[3] = "金"
        week[4] = "木"
        week[5] = "水"
        week[6] = "火"
        case 3:
            week[1] = "月"
            week[2] = "日"
            week[3] = "土"
            week[4] = "金"
            week[5] = "木"
            week[6] = "水"
        case 4:
            week[1] = "火"
            week[2] = "月"
            week[3] = "日"
            week[4] = "土"
            week[5] = "金"
            week[6] = "木"
        case 5:
            week[1] = "水"
            week[2] = "火"
            week[3] = "月"
            week[4] = "日"
            week[5] = "土"
            week[6] = "金"
        case 6:
            week[1] = "木"
            week[2] = "水"
            week[3] = "火"
            week[4] = "月"
            week[5] = "日"
            week[6] = "土"
        case 7:
            week[1] = "金"
            week[2] = "木"
            week[3] = "水"
            week[4] = "火"
            week[5] = "月"
            week[6] = "日"
        default: print(0)
        }
    }
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath){
            
            
            
            let weekDay = cell.contentView.viewWithTag(1) as! UILabel
            weekDay.text = week[indexPath.row]
            
            
            //            dashBoard.initialPro()
            
            var weekTotal = 0
            for index in 0...6 {
                weekTotal = weekTotal+stepsCountWeek[index]
            }
            thisWeekLabel.text = "\(weekTotal)kvh"
            let stepsCount = cell.contentView.viewWithTag(2) as! UILabel
            stepsCount.text = examination[indexPath.row]
            
            let stepsPoint = cell.contentView.viewWithTag(3) as! UILabel
            stepsPoint.text = examinationPoint[indexPath.row]
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examination.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "productivity2D"  {
            
            let productivity2D = segue.destinationViewController as! Productivity2DMeasureInputController
            //   dailyCourseCalendar.choosenDay =
//            let indexPath = tableView.indexPathForSelectedRow()?.row
            let indexPath = tableView.indexPathForSelectedRow()?.row
            var aa = 0
            while indexPath >= index[aa] {
                aa++
            }
            
            productivity2D.index = aa-1
            
        }
    }

}
