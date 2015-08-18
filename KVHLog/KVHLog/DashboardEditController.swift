

import UIKit

class DashboardEditController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var nextDayOutlet: UIButton!
    var choosenDayOk = NSDate()
    var choosenDayOn = 10000
    var index:NSTimeInterval = 0
    var isChanged = true
    var bigLabelText = ["選択した日の生産性","生産性を記録","アクティビティを記録"]
    
    
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
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        editButtonItem()

        load()
        tableView.allowsSelection = false
       
    }
    
//    override func editButtonItem() -> UIBarButtonItem {
//        return self.editButtonItem()
//    }
    
    
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DashboardEditCell", forIndexPath: indexPath) as! UITableViewCell
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        
        return cell
    }
    
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath){
            
            let bigLabel = cell.contentView.viewWithTag(1) as! UILabel
            bigLabel.text = bigLabelText[indexPath.row]
            
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .None:
            println()
//            self.items.removeObjectAtIndex(indexPath.row)
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        default:
            return
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //MARK: - UITabelView Delegate
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    }
}
