import UIKit

class AccountGoalController: UIViewController, UITextFieldDelegate {

    var t = 0
    var goalNumber = 21000
    var inputPercentage = 80
    @IBAction func ProductivityGoalsButton(sender: AnyObject) {
        t = 1
        textInput.alpha = 1.0
        kvhLabel.alpha = 1.0
        InputButton.alpha = 1.0
        percentLabel.alpha = 0.0
        alertLabel.alpha = 0.0
        
    }
    
    @IBAction func MonthlyInputRate(sender: AnyObject) {
        t = 2
        textInput.alpha = 1.0
        percentLabel.alpha = 1.0
        InputButton.alpha = 1.0
        kvhLabel.alpha = 0.0
    }
    
    
    @IBOutlet weak var alertLabel: UILabel!
    
    
    @IBOutlet weak var productivityGoal: UILabel!
    
    @IBOutlet weak var monthlyInputRate: UILabel!
    
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBOutlet weak var kvhLabel: UILabel!
    
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var InputButton: UIButton!
    
    @IBAction func inputButtonAction(sender: AnyObject) {
        switch t {
        case 1: productivityGoal.text = textInput.text
                textInput.text = ""
                textInput.alpha = 0.0
                kvhLabel.alpha = 0.0
                InputButton.alpha = 0.0
                percentLabel.alpha = 0.0
                alertLabel.alpha = 0.0
                self.view.endEditing(true)
                goalNumber = productivityGoal.text!.toInt()!
            
        case 2: monthlyInputRate.text = textInput.text
                var x = monthlyInputRate.text
                let y = x!.toInt()!
                if y <= 100 {
                    inputPercentage = y
                    textInput.text = ""
                    textInput.alpha = 0.0
                    kvhLabel.alpha = 0.0
                    InputButton.alpha = 0.0
                    percentLabel.alpha = 0.0
                    alertLabel.alpha = 0.0
                    self.view.endEditing(true)
                } else {
                    alertLabel.alpha = 1.0
                    textInput.text = ""
                }
        default: println(0)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInput.alpha = 0.0
        kvhLabel.alpha = 0.0
        InputButton.alpha = 0.0
        percentLabel.alpha = 0.0
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

}
