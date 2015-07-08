import UIKit

class AccountGoalController: UIViewController, UITextFieldDelegate {

    var t = 0
    var goalNumber = 21000
    var inputPercentage = 80
    @IBAction func ProductivityGoalsButton(sender: AnyObject) {
        t = 1
        textInput.alpha = 1.0
        kvhLabel.alpha = 1.0
        alertLabel.alpha = 0.0
        kvhLabel.text = "kvh"
        
    }
    
    @IBAction func MonthlyInputRate(sender: AnyObject) {
        t = 2
        textInput.alpha = 1.0
        kvhLabel.alpha = 1.0
        kvhLabel.text = "%"
    }
    
    
    @IBOutlet weak var alertLabel: UILabel!
    
    
    @IBOutlet weak var productivityGoal: UILabel!
    
    @IBOutlet weak var monthlyInputRate: UILabel!
    
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBOutlet weak var kvhLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var toolBar:UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.sizeToFit()
        
        var spacer:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        var commitButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "closeKeyboard:")
        let toolBarItems = [spacer,commitButton]
        toolBar.setItems(toolBarItems, animated: true)
        
        
        textInput.inputAccessoryView = toolBar
        
        
        textInput.alpha = 0.0
        kvhLabel.alpha = 0.0
        alertLabel.alpha = 0.0
        self.textInput.delegate = self
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func closeKeyboard(textView : UITextView){
        switch t {
        case 1: productivityGoal.text = textInput.text
        textInput.text = ""
        textInput.alpha = 0.0
        alertLabel.alpha = 0.0
        kvhLabel.alpha = 0.0
        self.view.endEditing(true)
        goalNumber = productivityGoal.text!.toInt()!
        textInput.resignFirstResponder()
            
        case 2: monthlyInputRate.text = textInput.text
        var x = monthlyInputRate.text
        let y = x!.toInt()!
        if y <= 100 {
            inputPercentage = y
            textInput.text = ""
            textInput.alpha = 0.0
            alertLabel.alpha = 0.0
            kvhLabel.alpha = 0.0
            
            textInput.resignFirstResponder()
            self.view.endEditing(true)
        } else {
            alertLabel.alpha = 1.0
            textInput.text = ""
            }
        default: println(0)
        }
        
    }

}
