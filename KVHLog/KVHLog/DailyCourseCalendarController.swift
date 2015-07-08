import UIKit

class DailyCourseCalendarController: TableOriginalController,UITableViewDelegate,UITableViewDataSource,WeeklyCalendarDelegate{
    


    
    @IBAction func nextDay(sender: AnyObject) {
        choosenDay = choosenDay.dateByAddingTimeInterval(24 * 60 * 60)
        viewDidLoad()
    }
    
    
    @IBAction func previousDay(sender: AnyObject) {
        choosenDay = choosenDay.dateByAddingTimeInterval(-24 * 60 * 60)
        viewDidLoad()
    }
    
    
    @IBOutlet weak var choosenDayLabel: UILabel!
    
    
    var index = 1
    
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
        
        
        changeLabel()
        // Do any additional setup after loading the view.
    }
    
    
    func changeLabel(){
        let calendars = Calendar()
        switch calendars.myWeekday(choosenDay) {
        case 1:choosenDayLabel.text = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(日)"
        case 2:choosenDayLabel.text = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(月)"
        case 3:choosenDayLabel.text = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(火)"
        case 4:choosenDayLabel.text = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(水)"
        case 5:choosenDayLabel.text = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(木)"
        case 6:choosenDayLabel.text = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(金)"
        case 7:choosenDayLabel.text = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(土)"
        default: println(0)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - UITableView Datasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 96
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        let timeLabel = cell.contentView.viewWithTag(1) as! UILabel
        
          timeLabel.text = timeFunc(indexPath)
       return cell
        
    }
    
    
    
    
    func timeFunc(indexPath:NSIndexPath) -> String {
        var a = ""
        if indexPath.row % 4 == 0 {
            if indexPath.row < 40 {
                a = "0\((indexPath.row)/4):00"
            }
            else {
                a = "\((indexPath.row)/4):00"
            }
        }
        if indexPath.row % 4 == 1 {
            a = "     15"
        }
        if indexPath.row % 4 == 2 {
            a = "     30"
        }
        if indexPath.row % 4 == 3 {
            a = "     45"
        }
        
        return a
    }
    
    //MARK: - UITableView Delegate
    
    //MARK: - UIStoryBorad Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowWeeklyCalendar"{
            let weeklyCalenderController = segue.destinationViewController as! WeeklyCalendarController
            weeklyCalenderController.delegate = self
         }
    }
    
    //MARK: - WeeklyCalendarDelegate
    
    func returnSelectedDate(date: NSDate) {
        println(date)
        choosenDay = date
        changeLabel()
    }
}
