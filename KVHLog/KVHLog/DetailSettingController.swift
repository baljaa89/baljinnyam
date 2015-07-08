import UIKit

class DetailSettingController: UIViewController {

    
    let dateFormatter = NSDateFormatter()
    @IBOutlet weak var notificationField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        var toolBar:UIToolbar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.Default
        toolBar.sizeToFit()
        
        var spacer:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        var commitButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "closeKeyboard:")
        let toolBarItems = [spacer,commitButton]
        toolBar.setItems(toolBarItems, animated: true)
        
        var datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Time
        
        notificationField.inputView = datePicker
        notificationField.inputAccessoryView = toolBar
        datePicker.addTarget(self, action: Selector("handleBirthdayPicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    
    //MARK: - Event Handler
    
    func handleBirthdayPicker(sender:UIDatePicker){
        notificationField.text = dateFormatFunc(sender.date, style:"HH:mm")
    }
    
    func closeKeyboard(textView : UITextView){
        notificationField.resignFirstResponder()
    }
    
    func dateFormatFunc(date:NSDate, style:String) -> String {
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = style
        return dateFormatter.stringFromDate(date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
