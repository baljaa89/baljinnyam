import UIKit

class ProductivityExaminationInputController: TableOriginalController, UITableViewDataSource, UITableViewDelegate {

    var colorArray:[UIColor] = [UIColor.darkGrayColor(),UIColor.greenColor()]
    var categoryArray:[String] = ["睡眠：よく眠れなかった","飲酒：お酒でストレスを解消できたみたい","健康：体力充実","前向きの気分","集中できた","発想力が豊かな日","その他"]
    
    
    @IBOutlet weak var numberOfSteps: UILabel!
    @IBOutlet weak var activeHour: UILabel!
    @IBOutlet weak var sleepingHour: UILabel!
    
    var examinationView:UIView!
    
    @IBAction func backToProductivityMeasure2D(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func examination(sender: AnyObject) {
        examinationView = UINib(nibName: "ExaminationView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        self.view.addSubview(examinationView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfSteps.textColor = UIColor.redColor()
        activeHour.textColor = UIColor.blueColor()
        sleepingHour.textColor = UIColor.greenColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Touch Event
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch:AnyObject in touches {
            var touch2:UITouch = touch as! UITouch
            if touch2.view.tag == 1 {
                self.examinationView.removeFromSuperview()
                navigationController?.popToRootViewControllerAnimated(true)
                
            }
        }
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
    
    override func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            if indexPath.row < categoryArray.count-1 {
            cell.textLabel?.text = categoryArray[indexPath.row]
            
            cell.textLabel?.font = UIFont.systemFontOfSize(10)
                
            }
            if indexPath.row == categoryArray.count-1 {
                let colorLabel = cell.contentView.viewWithTag(1) as! UILabel
                colorLabel.text = categoryArray[indexPath.row]
                
                let categoryLabel = cell.contentView.viewWithTag(2) as! UITextField
            }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    // name
    // MARK: - UITableView Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    
    

}
