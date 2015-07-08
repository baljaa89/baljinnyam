import UIKit

class ReportController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
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
    
    
    
    
    
    
    var reportList = ["歩数×生産性","睡眠時間×生産性","アクティブな時間×生産性","歩数×生産性ランク","睡眠時間×生産性ランク","あなたの業種で比較　購入200円","あなたの年代で比較　購入200円"]
    
    let calorie = [22000, 24000, 12000, 6000, 4000, 29000, 18000]
    let calorieMy = [12000, 4000, 2000, 16000, 7000, 9000, 13000]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView1.setTranslatesAutoresizingMaskIntoConstraints(true)
        var yy1 = 240 - (calorieMy[0]/200)
       myView1.frame = CGRectMake(75, CGFloat(yy1), 25, CGFloat(calorieMy[0]/200))
        if calorie[0] < calorieMy[0] {
        myView1.backgroundColor = UIColor.redColor()
        }
        
        myView2.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[1]/200)
        myView2.frame = CGRectMake(119, CGFloat(yy1), 25, CGFloat(calorieMy[1]/200))
        if calorie[1] < calorieMy[1] {
            myView2.backgroundColor = UIColor.redColor()
        }
        
        myView3.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[2]/200)
        myView3.frame = CGRectMake(163, CGFloat(yy1), 25, CGFloat(calorieMy[2]/200))
        if calorie[2] < calorieMy[2] {
            myView3.backgroundColor = UIColor.redColor()
        }
        
        myView4.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[3]/200)
        myView4.frame = CGRectMake(207, CGFloat(yy1), 25, CGFloat(calorieMy[3]/200))
        if calorie[3] < calorieMy[3] {
            myView4.backgroundColor = UIColor.redColor()
        }
        
        myView5.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[4]/200)
        myView5.frame = CGRectMake(251, CGFloat(yy1), 25, CGFloat(calorieMy[4]/200))
        if calorie[4] < calorieMy[4] {
            myView5.backgroundColor = UIColor.redColor()
        }
        
        myView6.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[5]/200)
        myView6.frame = CGRectMake(295, CGFloat(yy1), 25, CGFloat(calorieMy[5]/200))
        if calorie[5] < calorieMy[5] {
            myView6.backgroundColor = UIColor.redColor()
        }
        
        myView7.setTranslatesAutoresizingMaskIntoConstraints(true)
        yy1 = 240 - (calorieMy[6]/200)
        myView7.frame = CGRectMake(339, CGFloat(yy1), 25, CGFloat(calorieMy[6]/200))
        if calorie[6] < calorieMy[6] {
            myView7.backgroundColor = UIColor.redColor()
        }
        
        
        
        
        
        
        
        calorieView1.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y1 = 240 - (calorie[0]/200)
        calorieView1.frame = CGRectMake(65, CGFloat(y1), 27, CGFloat(calorie[0]/200))
        
        calorieView2.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y2 = 240 - (calorie[1]/200)
        calorieView2.frame = CGRectMake(109, CGFloat(y2), 27, CGFloat(calorie[1]/200))
        
        calorieView3.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y3 = 240 - (calorie[2]/200)
        calorieView3.frame = CGRectMake(153, CGFloat(y3), 27, CGFloat(calorie[2]/200))
        
        calorieView4.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y4 = 240 - (calorie[3]/200)
        calorieView4.frame = CGRectMake(197, CGFloat(y4), 27, CGFloat(calorie[3]/200))
        
        calorieView5.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y5 = 240 - (calorie[4]/200)
        calorieView5.frame = CGRectMake(241, CGFloat(y5), 27, CGFloat(calorie[4]/200))
        
        calorieView6.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y6 = 240 - (calorie[5]/200)
        calorieView6.frame = CGRectMake(285, CGFloat(y6), 27, CGFloat(calorie[5]/200))
        
        calorieView7.setTranslatesAutoresizingMaskIntoConstraints(true)
        let y7 = 240 - (calorie[6]/200)
        calorieView7.frame = CGRectMake(329, CGFloat(y7), 27, CGFloat(calorie[6]/200))
        
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
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportList.count
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
    }

}
