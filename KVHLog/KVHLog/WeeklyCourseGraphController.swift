import UIKit
import CoreData
class WeeklyCourseGraphController: TableOriginalController,UITableViewDelegate ,UITableViewDataSource {
    
    
//    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var thisWeekLabel: UILabel!
    
    
    
    var week:[String] = ["今日","木","水","火","月","日","土"]
//    var stepsCountWeek:[Int] = [0,0,0,0,0,0,0]
    var stepsCountWeek:[Int] = [0,0,0,0,0,0,0]
    var isAchievement:[CGFloat] = [1.0,1.0,1.0,1.0,1.0,1.0,1.0]
    var goalNumber = 21000
    var today = NSDate()
    var calendar = Calendar()
    let productivity = Productivity.sharedInstance.productivityCalculator()
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getT_productivityData()
        getM_objectiveData()
        var backButton = UIBarButtonItem(title: "戻る", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UITableView Datasource
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StepsCountCell", forIndexPath: indexPath) as! UITableViewCell
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    override func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath){
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
            
            
            let weekDay = cell.contentView.viewWithTag(1) as! UILabel
            weekDay.text = week[indexPath.row]
            
            
//            dashBoard.initialPro()
//            for index in 0...6 {
//                stepsCountWeek[index] = productivity[10000-index]
//            }
            var weekTotal = 0
            for index in 0...6 {
                weekTotal = weekTotal+stepsCountWeek[index]
            }
            thisWeekLabel.text = "\(weekTotal)kvh"
            let stepsCount = cell.contentView.viewWithTag(2) as! UILabel
            stepsCount.text = "\(stepsCountWeek[indexPath.row])kvh"
            
            let achievementImage = cell.contentView.viewWithTag(3) as! UIImageView
            for index in 0...6 {
                if stepsCountWeek[index] >= goalNumber {
                    isAchievement[index] = 1.0
                }
                else
                {
                    isAchievement[index] = 0.0
                }
            }
            achievementImage.alpha = isAchievement[indexPath.row]
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "dailyCourseCalendar"  {
            
            let dailyCourseCalendar = segue.destinationViewController as! DailyCourseCalendarController
         //   dailyCourseCalendar.choosenDay =
            let indexPath = tableView.indexPathForSelectedRow()?.row
            
            dailyCourseCalendar.index = indexPath!
            
        }
    }
    
    
    //MARK: - CoreData Fetch
    
    func getT_productivityData(){
        let request = NSFetchRequest(entityName: "T_productivity")
        var error: NSError? = nil
        let results:[T_productivity] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) as! [T_productivity]
        
        
        
        for var i:Int = 0;i<7; i++ {
            var choosenDay = NSDate()
            choosenDay = choosenDay.dateByAddingTimeInterval(NSTimeInterval(-i * 24 * 60 * 60))
            for t_productivity in results {
                if calendar.myYear(choosenDay) == calendar.myYear(t_productivity.dateTime) && calendar.myMonth(choosenDay) == calendar.myMonth(t_productivity.dateTime) && calendar.myDay(choosenDay) == calendar.myDay(t_productivity.dateTime){
                    stepsCountWeek[i] = t_productivity.productivity.integerValue
                }
            }
        }
        // 月間入力数をデータベースに保存する
        var summary = Array<[Int]>(count: 42,
            repeatedValue: [Int](count: 13, repeatedValue: 0))
        
        for t_productivity in results{
            let year  = calendar.myYear(t_productivity.dateTime)
            let month = calendar.myMonth(t_productivity.dateTime)
                summary[year-2000][month]++
        }
        var year = 0
        var month = 1
        var x = 0
        for var i = 0; i < 42; ++i
        {
            for var j = 1; j<13; ++j
            {
                if summary[i][j]>0
                {
                    year = i
                    month = j
                    x = 1
                    break
                }
            }
            if x > 0
            {
                break
            }
        }
        println(year)
        var date  = NSDate()
        
        var className:String = "T_minputrate"
        let myEntity: NSEntityDescription! = NSEntityDescription.entityForName(className, inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
        let t_minputrate = T_minputrate(entity: myEntity, insertIntoManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        
       
        
        
        for var i = year; i < calendar.myYear(date)-1999; ++i
        {
            for var j = 1; j<13; j++
            {
                if(summary[i][j]>0)
                {
                    if j<10
                    {
                        t_minputrate.month = "\(year+2000)0\(j)"
                    }
                    else
                    {
                        t_minputrate.month = "\(year+2000)\(j)"
                    }
                    t_minputrate.inputcount = summary[i][j]
                    t_minputrate.daycount = dayCount(i, month:j)
                 //   println("year is \(j)   \(t_minputrate.inputcount)   \(t_minputrate.daycount)")
                     CoreDataManager.sharedInstance.saveContext()
                }
            }
        }
        
    }
    
    
    //月の最終日を返す関数
    func dayCount(year:Int, month:Int) -> Int
    {
        switch month
        {
        case 1,3,5,7,8,10,12: return 31
        case 4,6,9,11: return 30
        case 2: if year % 4 == 0 {return 29} else {return 28}
        default: return 0
        }
    }
    
    func getM_objectiveData(){
        let request = NSFetchRequest(entityName: "M_objective")
        var error: NSError? = nil
        let results: [M_objective] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) as! [M_objective]
        
        for m_objective in results {
            goalNumber =  m_objective.productive_obj.integerValue
        }
    }
}
