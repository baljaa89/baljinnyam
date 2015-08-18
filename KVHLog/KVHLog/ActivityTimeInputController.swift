import UIKit
import CoreData

class ActivityTimeInputController: UIViewController {
    
    var activityResults:String!
    var categoryResults:String!
    var choosenDay:NSDate!
    var indexPath:NSIndexPath!
    
    @IBOutlet weak var selectedActivityField: UITextField!
    
    @IBOutlet weak var memoTextview: UITextView!
    
    @IBAction func backToActivitySelected(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func popToWeeklyCourseCalendar(sender: AnyObject) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    
    @IBOutlet weak var timePickerBegin: UIDatePicker!
    
    @IBOutlet weak var timePickerEnd: UIDatePicker!
    
    
    func didPushRegisterButtonItem(){
        var calendar = Calendar()
        if calendar.myHour(timePickerBegin.date) < calendar.myHour(timePickerEnd.date)
        {
            insertIntoActivity()
            
        }else if calendar.myHour(timePickerBegin.date) == calendar.myHour(timePickerEnd.date){
            if calendar.myMinute(timePickerBegin.date) <= calendar.myMinute(timePickerEnd.date)
            {
                insertIntoActivity()
            }
            else
            {
                showAlertController("エラー", message: "終了時間が開始時間よりも後になるようにしてください。")
            }
        }
        else
        {
           showAlertController("エラー", message: "終了時間が開始時間よりも後になるようにしてください。")
        }
    }
    
    func insertIntoActivity(){
        let request = NSFetchRequest(entityName: "T_activity")
        var error: NSError? = nil
        
        var className:String = "T_activity"
        let myEntity: NSEntityDescription! = NSEntityDescription.entityForName(className, inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
        let t_activity = T_activity(entity: myEntity, insertIntoManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        t_activity.activity = activityResults
        t_activity.memo = memoTextview.text
        t_activity.starttime = timePickerBegin.date
        t_activity.endtime = timePickerEnd.date
        t_activity.created = NSDate()
        t_activity.modified = NSDate()
        
        CoreDataManager.sharedInstance.saveContext()
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let calendars = Calendar()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        var startDate = formatter.dateFromString("\(calendars.myYear(choosenDay))/\(calendars.myMonth(choosenDay))/\(calendars.myDay(choosenDay)) \(indexPath.row/4):\((indexPath.row%4)*15):00")
        
        
       timePickerBegin.date = startDate!
       timePickerEnd.date = startDate!
        getT_ActivityData()
        
        navigationItem.title = "name"
        
        
        switch calendars.myWeekday(choosenDay) {
        case 1:navigationItem.title = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(日)"
        case 2:navigationItem.title = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(月)"
        case 3:navigationItem.title = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(火)"
        case 4:navigationItem.title = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(水)"
        case 5:navigationItem.title = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(木)"
        case 6:navigationItem.title = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(金)"
        case 7:navigationItem.title = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))(土)"
        default: println(0)
            
        }
        
        //UIBarButtonItem
        var registerItemButton = UIBarButtonItem(title: "登録", style: UIBarButtonItemStyle.Plain, target: self, action: "didPushRegisterButtonItem")
        navigationItem.rightBarButtonItem = registerItemButton
        
        //ActivityFiled
        selectedActivityField.text = "\(activityResults):\(categoryResults)"
        
        //MemoTextView
        var toolBar:UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.sizeToFit()
        
        var spacer:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        var commitButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "closeKeyboard:")
        let toolBarItems = [spacer,commitButton]
        toolBar.setItems(toolBarItems, animated: true)
        
        memoTextview.layer.masksToBounds = true
        memoTextview.layer.cornerRadius = 5.0
        memoTextview.layer.borderWidth = 0.1
        memoTextview.layer.borderColor = UIColor.darkGrayColor().CGColor
        memoTextview.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - CoreData Fetch
    
    func getT_ActivityData(){
        let request = NSFetchRequest(entityName: "T_activity")
        request.predicate = NSPredicate(format: "activity like %@", activityResults)
        var error: NSError? = nil
        let results: NSArray = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for t_activity in results {
            memoTextview.text = t_activity.memo
            timePickerBegin.date = t_activity.starttime
            timePickerEnd.date = t_activity.endtime
            choosenDay = t_activity.starttime
        }
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func closeKeyboard(textView : UITextView){
        memoTextview.resignFirstResponder()
    }
    
    //MARK: - AlertController
    
    func showAlertController(title: NSString?, message: NSString?){
        let alertController = UIAlertController(title: title as? String, message: message as? String, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}
