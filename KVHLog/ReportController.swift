import UIKit
import CoreData

class ReportController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var secondGraphLabel: UILabel!
    @IBOutlet weak var firstGraphLabel: UILabel!
    
    
    
    @IBOutlet weak var fullLabel: UILabel!
    @IBOutlet weak var halfPlusLabel: UILabel!
    @IBOutlet weak var halfMinusLabel: UILabel!
    @IBOutlet weak var zeroLabel: UILabel!
    
    
    @IBOutlet weak var weeksLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    
    
    @IBOutlet weak var fullLineLabel: UIView!
    @IBOutlet weak var halfPlusLineView: UIView!
    @IBOutlet weak var halfMinusLineView: UIView!
    @IBOutlet weak var zeroLineLabel: UIView!
    
    
    
    @IBOutlet weak var yellowLine1: UILabel!
    @IBOutlet weak var yellowLine2: UILabel!
    @IBOutlet weak var yellowLine3: UILabel!
    @IBOutlet weak var yellowLine4: UILabel!
    
    
    
    
    
    
    
    @IBOutlet weak var calorieView1: UIView!
    @IBOutlet weak var calorieView2: UIView!
    @IBOutlet weak var calorieView3: UIView!
    @IBOutlet weak var calorieView4: UIView!
    @IBOutlet weak var calorieView5: UIView!
    @IBOutlet weak var calorieView6: UIView!
    @IBOutlet weak var calorieView7: UIView!
    
    
    
    @IBOutlet weak var myView1: UIView!
    @IBOutlet weak var myView2: UIView!
    @IBOutlet weak var myView3: UIView!
    @IBOutlet weak var myView4: UIView!
    @IBOutlet weak var myView5: UIView!
    @IBOutlet weak var myView6: UIView!
    @IBOutlet weak var myView7: UIView!
    
    var calendar = Calendar()
    
    
    
    
    var reportList = ["歩数×生産性","睡眠時間×生産性","アクティブな時間×生産性","歩数×生産性ランク","睡眠時間×生産性ランク"]
    var firstGraphName = ["生産性","生産性","生産性","生産性ランク","生産性ランク"]
    var secondGraphName = ["歩数","睡眠時間","アクティブな時間","歩数","睡眠時間"]
    var calorie = [[22000, 24000, 12000, 6000, 4000, 29000, 18000],[22000, 24000, 12000, 6000, 4000, 29000, 18000],[22000, 24000, 12000, 6000, 4000, 29000, 18000],[1,2,2,5,3,2,4],[1,2,2,5,3,2,4]]
    var calorieMy = [[12000, 4000, 2000, 16000, 7000, 9000, 13000],[1,2,24,3,19,23,22],[5,6,5,9,2,4,10],[12000, 4000, 2000, 16000, 7000, 9000, 13000],[1,2,24,3,19,23,22]]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getT_productivityData()
        refreshGraphView(0)
     
        
    }
    
    func refreshGraphView(row:Int){
        
        var mm = 45
        var ms = 247
        var mq = 335
        var mi = 300
        var mj = 370
        
        var full = 60000
        var fullY = 30000
        
        switch self.view.frame.size.width {
        case 320:   mm = 30
        ms = 200
        mq = 250
        mi = 220
        mj = 283
        weeksLabel.font = UIFont.systemFontOfSize(10)
        case 375:   mm = 39
        ms = 233
        mq = 305
        mi = 270
        mj = 339
        weeksLabel.font = UIFont.systemFontOfSize(13)
        default: println()
        }
        
        
        firstGraphLabel.text = firstGraphName[row]
        secondGraphLabel.text = secondGraphName[row]
        
        
        switch row {
        case 1:
            full = 24
        case 2:
            full = 24
        case 3:
            fullY = 6
            full = 60000
        case 4:
            fullY = 6
            full = 24
        default:println()
        }
        
        
        
        fullLineLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        fullLineLabel.frame = CGRectMake(60, 90, CGFloat(mi), 1)
        halfPlusLineView.setTranslatesAutoresizingMaskIntoConstraints(true)
        halfPlusLineView.frame = CGRectMake(60, 140, CGFloat(mi), 1)
        halfMinusLineView.setTranslatesAutoresizingMaskIntoConstraints(true)
        halfMinusLineView.frame = CGRectMake(60, 190, CGFloat(mi), 1)
        zeroLineLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        zeroLineLabel.frame = CGRectMake(60, 240, CGFloat(mi), 1)
        
        
        fullLabel.text = "\(fullY)"
        halfPlusLabel.text = "\(fullY*2/3)"
        halfMinusLabel.text = "\(fullY/3)"
        
        yellowLine1.text = "\(full)"
        yellowLine2.text = "\(full*2/3)"
        yellowLine3.text = "\(full/3)"
        
        yellowLine1.setTranslatesAutoresizingMaskIntoConstraints(true)
        yellowLine1.frame = CGRectMake(CGFloat(mj), 80, 40, 21)
        yellowLine2.setTranslatesAutoresizingMaskIntoConstraints(true)
        yellowLine2.frame = CGRectMake(CGFloat(mj), 130, 40, 21)
        yellowLine3.setTranslatesAutoresizingMaskIntoConstraints(true)
        yellowLine3.frame = CGRectMake(CGFloat(mj), 180, 40, 21)
        yellowLine4.setTranslatesAutoresizingMaskIntoConstraints(true)
        yellowLine4.frame = CGRectMake(CGFloat(mj), 230, 40, 21)
        
        
        
        weeksLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        weeksLabel.frame = CGRectMake(67, 255, CGFloat(ms), 21)
        
        
        todayLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        todayLabel.frame = CGRectMake(CGFloat(mq), 255, 17, 21)
        
        
        myView1.setTranslatesAutoresizingMaskIntoConstraints(true)
        var yy1 = 240 - (calorieMy[row][0]*150/full)
        myView1.frame = CGRectMake(77, CGFloat(yy1), 12, CGFloat(calorieMy[row][0]*150/full))
//        if calorie[0] < calorieMy[0] {
//            myView1.backgroundColor = UIColor.redColor()
//        }
        
        myView2.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[row][1]*150/full)
        myView2.frame = CGRectMake(CGFloat(77+mm*1), CGFloat(yy1), 12, CGFloat(calorieMy[row][1]*150/full))
//        if calorie[1] < calorieMy[1] {
//            myView2.backgroundColor = UIColor.redColor()
//        }
        
        myView3.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[row][2]*150/full)
        myView3.frame = CGRectMake(CGFloat(77+mm*2), CGFloat(yy1), 12, CGFloat(calorieMy[row][2]*150/full))
//        if calorie[2] < calorieMy[2] {
//            myView3.backgroundColor = UIColor.redColor()
//        }
        
        myView4.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[row][3]*150/full)
        myView4.frame = CGRectMake(CGFloat(77+mm*3), CGFloat(yy1), 12, CGFloat(calorieMy[row][3]*150/full))
//        if calorie[3] < calorieMy[3] {
//            myView4.backgroundColor = UIColor.redColor()
//        }
        
        myView5.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[row][4]*150/full)
        myView5.frame = CGRectMake(CGFloat(77+mm*4), CGFloat(yy1), 12, CGFloat(calorieMy[row][4]*150/full))
//        if calorie[4] < calorieMy[4] {
//            myView5.backgroundColor = UIColor.redColor()
//        }
        
        myView6.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[row][5]*150/full)
        myView6.frame = CGRectMake(CGFloat(77+mm*5), CGFloat(yy1), 12, CGFloat(calorieMy[row][5]*150/full))
//        if calorie[5] < calorieMy[5] {
//            myView6.backgroundColor = UIColor.redColor()
//        }
//        
        myView7.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[row][6]*150/full)
        myView7.frame = CGRectMake(CGFloat(77+mm*6), CGFloat(yy1), 12, CGFloat(calorieMy[row][6]*150/full))
//        if calorie[6] < calorieMy[6] {
//            myView7.backgroundColor = UIColor.redColor()
//        }
        
        
        
        
        
        
        
        calorieView1.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y1 = 240 - (calorie[row][0]*150/fullY)
        calorieView1.frame = CGRectMake(65, CGFloat(y1), 12, CGFloat(calorie[row][0]*150/fullY))
        
        calorieView2.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y2 = 240 - (calorie[row][1]*150/fullY)
        calorieView2.frame = CGRectMake(CGFloat(65+mm*1), CGFloat(y2), 12, CGFloat(calorie[row][1]*150/fullY))
        
        calorieView3.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y3 = 240 - (calorie[row][2]*150/fullY)
        calorieView3.frame = CGRectMake(CGFloat(65+mm*2), CGFloat(y3), 12, CGFloat(calorie[row][2]*150/fullY))
        
        calorieView4.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y4 = 240 - (calorie[row][3]*150/fullY)
        calorieView4.frame = CGRectMake(CGFloat(65+mm*3), CGFloat(y4), 12, CGFloat(calorie[row][3]*150/fullY))
        
        calorieView5.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y5 = 240 - (calorie[row][4]*150/fullY)
        calorieView5.frame = CGRectMake(CGFloat(65+mm*4), CGFloat(y5), 12, CGFloat(calorie[row][4]*150/fullY))
        
        calorieView6.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y6 = 240 - (calorie[row][5]*150/fullY)
        calorieView6.frame = CGRectMake(CGFloat(65+mm*5), CGFloat(y6), 12, CGFloat(calorie[row][5]*150/fullY))
        
        calorieView7.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y7 = 240 - (calorie[row][6]*150/fullY)
        calorieView7.frame = CGRectMake(CGFloat(65+mm*6), CGFloat(y7), 12, CGFloat(calorie[row][6]*150/fullY))
        
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    // MARK: - UITableViewDataSource
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReportCell", forIndexPath: indexPath) as! UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath){
            
            cell.textLabel!.text = reportList[indexPath.row]
            switch self.view.frame.size.width {
            case 320: cell.textLabel!.font = UIFont.systemFontOfSize(12)
            case 375: cell.textLabel!.font = UIFont.systemFontOfSize(14)
            default: println()
            }
            
            
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch self.view.frame.size.width {
        case 320: return 32.0
        case 375: return 52.0
        case 414: return 65.0
        default: return 80.0
        }
        
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        refreshGraphView(indexPath.row)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
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
                    calorie[0][6-i] = t_productivity.productivity.integerValue
                    calorie[1][6-i] = t_productivity.productivity.integerValue
                    calorie[2][6-i] = t_productivity.productivity.integerValue
                }
            }
        }
    }

}
