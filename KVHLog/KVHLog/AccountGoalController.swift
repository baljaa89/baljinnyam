import UIKit
import CoreData

class AccountGoalController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBAction Method
    
    @IBAction func didPushRegisterButton(sender: AnyObject) {
        
        if productivityGoal.text != "生産性目標" && monthlyInputRate.text != "月間入力率" {
            saveToM_Objective()
        }else{
            showAlertController("エラー", message: "データを入力してください")
        }
    }
    
    func saveToM_Objective(){
        
        let request = NSFetchRequest(entityName: "M_objective")
        var error: NSError? = nil
        var className:String = "M_objective"
        
        if let results = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) {
            for result in results {
                CoreDataManager.sharedInstance.managedObjectContext!.deleteObject(result as! NSManagedObject)
            }
        }
        
        let myEntity: NSEntityDescription! = NSEntityDescription.entityForName(className, inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
        let m_objective = M_objective(entity: myEntity, insertIntoManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        
        m_objective.productive_obj = NSNumber(integer: productivityGoal.text!.toInt()!)
        m_objective.input_obj = NSNumber(integer: monthlyInputRate.text!.toInt()!)

        
        
        CoreDataManager.sharedInstance.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func ProductivityGoalsButton(sender: AnyObject) {
        isTouchedButton = 1
        textInput.alpha = 1.0
        kvhLabel.alpha = 1.0
        alertLabel.alpha = 0.0
        kvhLabel.text = "kvh"
        
    }
    
    @IBAction func MonthlyInputRate(sender: AnyObject) {
        isTouchedButton = 2
        textInput.alpha = 1.0
        kvhLabel.alpha = 1.0
        kvhLabel.text = "%"
    }
    
    
    @IBOutlet weak var alertLabel: UILabel!
    
    
    @IBOutlet weak var productivityGoal: UILabel!
    
    @IBOutlet weak var monthlyInputRate: UILabel!
    
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBOutlet weak var kvhLabel: UILabel!
    
    var isTouchedButton = 0
    var goalNumber = 21000
    var inputPercentage = 80
    
    //MARK: - View LifeCycle
    
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
        
        getM_objectiveData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - CoreData Fetch
    
    func getM_objectiveData(){
        let request = NSFetchRequest(entityName: "M_objective")
        var error: NSError? = nil
        let results: NSArray = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for m_objective in results {
            productivityGoal.text =  "\(m_objective.productive_obj)"
            monthlyInputRate.text = "\(m_objective.input_obj)"
        }
    }
    
    //MARK: - UITextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //MARK: - AlertController
    
    func showAlertController(title: NSString?, message: NSString?){
        let alertController = UIAlertController(title: title as? String, message: message as? String, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }

    //MARK: - Event Handler
    
    func closeKeyboard(textView : UITextView){
        switch isTouchedButton {
        case 1:
            if let intByText = textInput.text.toInt(){
                if intByText < 32768 {
                productivityGoal.text = textInput.text
                textInput.text = ""
                textInput.alpha = 0.0
                alertLabel.alpha = 0.0
                kvhLabel.alpha = 0.0
                self.view.endEditing(true)
                goalNumber = productivityGoal.text!.toInt()!
                textInput.resignFirstResponder()
                }else {
                    textInput.text = ""
                    showAlertController("エラー", message: "32768 以下の数字を入れてください")
                }
            }
            
        case 2:
            if let intByText = textInput.text.toInt(){
                if intByText <= 100 {
                    monthlyInputRate.text = textInput.text
                    inputPercentage = intByText
                    textInput.text = ""
                    textInput.alpha = 0.0
                    alertLabel.alpha = 0.0
                    kvhLabel.alpha = 0.0
                    
                    textInput.resignFirstResponder()
                    self.view.endEditing(true)
                } else {
                    
                    textInput.text = ""
                    showAlertController("エラー", message: "100　以下の数字を入れてください")
                }
            }
       
        default: println(0)
        }
        
    }
    
    

}
