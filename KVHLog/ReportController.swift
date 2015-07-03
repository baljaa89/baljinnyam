import UIKit

class ReportController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var reportList = ["歩数×生産性","睡眠時間×生産性","アクティブな時間×生産性","歩数×生産性ランク","睡眠時間×生産性ランク","あなたの業種で比較　購入200円","あなたの年代で比較　購入200円"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
