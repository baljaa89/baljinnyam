import UIKit

class ActivityTimeInputController: UIViewController {
    @IBAction func done(sender: AnyObject) {
        self.view.endEditing(true)
    }
    var choosenDay = NSDate()
    
    
    @IBOutlet weak var timePickerBegin: UIDatePicker!
    
    @IBOutlet weak var timePickerEnd: UIDatePicker!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "name"
        let calendars = CalendarController()
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

}
