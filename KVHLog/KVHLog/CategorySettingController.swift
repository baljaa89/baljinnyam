
import UIKit

class CategorySettingController: UITableViewController,UITableViewDelegate, UITableViewDataSource {
    
    var colorArray:[UIColor] = [UIColor.darkGrayColor(),UIColor.greenColor()]
    var categoryArray:[String] = ["仕事","name"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - tableView datasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return categoryArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
        
    }
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            
            let colorLabel = cell.contentView.viewWithTag(1) as! UILabel
            colorLabel.backgroundColor = colorArray[indexPath.row]
            
            let categoryLabel = cell.contentView.viewWithTag(2) as! UILabel
            categoryLabel.text = categoryArray[indexPath.row]
    }
    
    // name
    // MARK: - UITableView Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
    }

}
