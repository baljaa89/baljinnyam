import UIKit

class ActivityTimeInputController: UIViewController {
    
    
    @IBOutlet weak var selectedActivityField: UITextField!
    
    @IBOutlet weak var memoTextview: UITextView!
    
    @IBAction func backToActivitySelected(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    var choosenDay = NSDate()
    
    
    
    
    
    @IBAction func popToWeeklyCourseCalendar(sender: AnyObject) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
    }
    
    
    @IBOutlet weak var timePickerBegin: UIDatePicker!
    
    @IBOutlet weak var timePickerEnd: UIDatePicker!
    
    func didPushRegisterButtonItem(){
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        var registerItemButton = UIBarButtonItem(title: "登録", style: UIBarButtonItemStyle.Plain, target: self, action: "didPushRegisterButtonItem")
        navigationItem.rightBarButtonItem = registerItemButton
        
        
        
        
        
        navigationItem.title = "name"
        let calendars = Calendar()
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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func closeKeyboard(textView : UITextView){
        memoTextview.resignFirstResponder()
    }
}
