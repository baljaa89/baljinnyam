

import UIKit

class DashboardEditController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var nextDayOutlet: UIButton!
    var choosenDayOk = NSDate()
    var choosenDayOn = 10000
    var index:NSTimeInterval = 0
    var isChanged = true
    @IBAction func nextDay(sender: AnyObject) {
        if choosenDayOn < 10000 {
        choosenDayOk = choosenDayOk.dateByAddingTimeInterval(24 * 60 * 60)
        choosenDayOn++
        load()
        }
    }
    @IBAction func previousDay(sender: AnyObject) {
        choosenDayOk = choosenDayOk.dateByAddingTimeInterval(-24 * 60 * 60)
        choosenDayOn--
        load()
    }
    
    @IBOutlet weak var choosenDay: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    
    func load(){
        if isChanged {
            choosenDayOn = choosenDayOn + Int(index)
            isChanged = false
            choosenDayOk = choosenDayOk.dateByAddingTimeInterval(index*24 * 60 * 60)
        }
        if choosenDayOn == 10000 {
            nextDayOutlet.tintColor = UIColor.lightGrayColor()
        }
        else
        {
            nextDayOutlet.tintColor = UIColor.greenColor()
        }
        super.viewDidLoad()
        let calendars = Calendar()
        
        if choosenDayOn < 10000
        {
            choosenDay.text = "\(calendars.myYear(choosenDayOk))年\(calendars.myMonth(choosenDayOk))月\(calendars.myDay(choosenDayOk))日"
        }
        else
            if choosenDayOn == 10000
            {
                choosenDay.text = "今日"
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    // MARK: - UITableViewDataSource
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DashboardEditCell", forIndexPath: indexPath) as! UITableViewCell
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        
        return cell
    }
    
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath){
            
            let redShapeView = cell.contentView.viewWithTag(4)
            redShapeView!.setTranslatesAutoresizingMaskIntoConstraints(true)
            
            var sizeFrame = self.view.frame.size.width
//            var sizeFrames = sizeFrame-(132*(sizeFrame+1000)/1414)
//            let size = CGFloat(sizeFrames*1.0)
//            redShapeView?.frame = CGRectMake(82*(sizeFrame+1000)/1414, 49
//                ,size , 7)
            
            
            let blackShapeView = cell.contentView.viewWithTag(5)
            
            switch sizeFrame {
            case 320:
                redShapeView?.frame = CGRectMake(77, 49 ,206*0.8 , 7)
            case 375:redShapeView?.frame = CGRectMake(78, 49 ,259 , 7)
            case 414:
                redShapeView?.frame = CGRectMake(82, 49 ,282 , 7)
            default: println("ali n ch bish")
            }
          //   var sizeFrame = self.view.frame.size.width
            println(blackShapeView?.frame.size.width)
            
            
            
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 123
    }
}
