import UIKit
import CoreData

class ProductivityExaminationInputController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var colorArray:[UIColor] = [UIColor.darkGrayColor(),UIColor.greenColor()]
//    var categoryArray:[String] = ["睡眠：よく眠れなかった","飲酒：お酒でストレスを解消できたみたい","健康：体力充実","前向きの気分","集中できた","発想力が豊かな日","その他"]
    var categoryArray:[String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfSteps: UILabel!
    @IBOutlet weak var activeHour: UILabel!
    @IBOutlet weak var sleepingHour: UILabel!
    
    var examinationView:UIView!
    
    var choosenDay:NSDate!
    var rank:String!
    var difficulty:Int!
    var achieve:Int!
    var calendar = Calendar()
    var categoryField:UITextField!
    var selectedCells:[String:Bool]=[String:Bool]()
    
    @IBAction func didPushRegisterButton(sender: AnyObject) {
        
        //Insert into T_productivity
        let request = NSFetchRequest(entityName: "T_productivity")
        var error: NSError? = nil
        
        var className:String = "T_productivity"
        let myEntity: NSEntityDescription! = NSEntityDescription.entityForName(className, inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
        let t_productivity = T_productivity(entity: myEntity, insertIntoManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        
        //Fetch from T_productivity
        var error2: NSError? = nil
        
        let results2:[T_productivity] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) as! [T_productivity]
        
        for t_productivity in results2{
            if calendar.myYear(choosenDay) == calendar.myYear(t_productivity.dateTime) && calendar.myMonth(choosenDay) == calendar.myMonth(t_productivity.dateTime) && calendar.myDay(choosenDay) == calendar.myDay(t_productivity.dateTime){
                CoreDataManager.sharedInstance.managedObjectContext!.deleteObject(t_productivity as NSManagedObject)
            }
        }
        
        t_productivity.dateTime = choosenDay
        t_productivity.difficulty = difficulty
        t_productivity.achieve = achieve
        t_productivity.productivity = Int(arc4random_uniform(30000))
        t_productivity.rank  = rank
        t_productivity.created = NSDate()
        t_productivity.created_by = "dfs"
        t_productivity.modified = NSDate()
        t_productivity.modified_by = "dfsdfs"
        
//        let indexPaths = tableView.indexPathsForSelectedRows()
//        if let indexPath = tableView.indexPathForSelectedRow(){
//            t_productivity.measure = indexPath.row == categoryArray.count-1 ? categoryField.text : categoryArray[indexPath.row]
//        }else{
//            t_productivity.measure = ""
//        }
        
        if let indexPaths = tableView.indexPathsForSelectedRows(){
            var appendStr = ""
            for indexPath in indexPaths{
                if indexPath.row == categoryArray.count-1 {
                        appendStr = appendStr + categoryField.text + ","
                }
                else
                {
                            appendStr = appendStr + categoryArray[indexPath.row] + ","
                }
             //   t_productivity.measure = indexPath.row == categoryArray.count-1 ? categoryField.text : categoryArray[indexPath.row]
            }
            t_productivity.measure = dropLast(appendStr)
        }else{
            t_productivity.measure = ""
        }
        
        
        CoreDataManager.sharedInstance.saveContext()
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
        
        let user_id = "shima"
        let pass = "passwd"
        
//        sendingT_productivityData("http://www.koshiki.co.jp:8080/neurostar/api/productivityc?procid=1&user_id=\(user_id)&passwd=\(pass)&dateInput=2015-07-27 00:00:00&difficulty=\(difficulty)&achieve=\(achieve)&productivity=\(t_productivity.productivity.integerValue)&rank=\(rank)")
//        let parameters = []
//        sendingT_productivityData("http://www.koshiki.co.jp:8080/neurostar/api/productivityc?",)
        
    }
    
    @IBAction func backToProductivityMeasure2D(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func examination(sender: AnyObject) {
        examinationView = UINib(nibName: "ExaminationView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        self.view.addSubview(examinationView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getM_questionaire(rank)
        if categoryArray.count == 1 {
            for var i = 0; i<6; ++i {
            categoryArray.insert("fada\(i)", atIndex: 0)
            }
        }
        
        self.tableView.allowsMultipleSelection = true
    
        numberOfSteps.textColor = UIColor.redColor()
        activeHour.textColor = UIColor.blueColor()
        sleepingHour.textColor = UIColor.greenColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - CoreData Method
    
    func getM_questionaire(rank:String){
        let request = NSFetchRequest(entityName: "M_questionaire")
        var error: NSError? = nil
        let results:[M_questionaire] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) as! [M_questionaire]

        for m_questionaire in results {
            categoryArray.append(m_questionaire.questionaire)
        }
        categoryArray.append("その他")
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return categoryArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! UITableViewCell
        configureCell(cell, atIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let key = "\(indexPath.section)-\(indexPath.row)"
        if let selected = selectedCells[key]{
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
        
    }
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            if indexPath.row < categoryArray.count-1 {
            cell.textLabel?.text = categoryArray[indexPath.row]
            
            cell.textLabel?.font = UIFont.systemFontOfSize(10)
                
            }
            if indexPath.row == categoryArray.count-1 {
                let colorLabel = cell.contentView.viewWithTag(1) as! UILabel
                colorLabel.text = categoryArray[indexPath.row]
                
                categoryField = cell.contentView.viewWithTag(2) as! UITextField
                categoryField.setTranslatesAutoresizingMaskIntoConstraints(true)
                categoryField.frame = CGRectMake(108, 5, 200, 30)
            }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    // name
    // MARK: - UITableView Delegate
    
      func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        var _cell = tableView.cellForRowAtIndexPath(indexPath)
        if let cell=_cell{
            
            let key = "\(indexPath.section)-\(indexPath.row)"
            
            if cell.accessoryType == UITableViewCellAccessoryType.None{
                cell.accessoryType=UITableViewCellAccessoryType.Checkmark
                selectedCells[key]=true;
            }else{
                cell.accessoryType=UITableViewCellAccessoryType.None
                selectedCells.removeValueForKey(key)
            }
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
    }

}
