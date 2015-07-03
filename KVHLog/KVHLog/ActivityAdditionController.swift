
import UIKit

class ActivityAdditionController: UIViewController, ColorSettingDelegate,UITextFieldDelegate {
    @IBOutlet weak var colorLabel: UILabel!
    
    var colorSettingController:ColorSettingController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var backButton = UIBarButtonItem(title: "戻る", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowColorSetting" {
            colorSettingController = segue.destinationViewController as! ColorSettingController
            colorSettingController.delegate = self
        }
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
         self.view.endEditing(true)
        return true
    }
    
    //MARK: - ColorSettingDelegate
    
    func getSelectedColor(indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:  colorLabel.backgroundColor = UIColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        case 1:colorLabel.backgroundColor = UIColor.redColor()
        case 2:colorLabel.backgroundColor = UIColor.blueColor()
        case 3:colorLabel.backgroundColor = UIColor.grayColor()
        case 4:colorLabel.backgroundColor = UIColor.lightGrayColor()
        case 5:colorLabel.backgroundColor = UIColor.greenColor()
        case 6:colorLabel.backgroundColor = UIColor.orangeColor()
        case 7:colorLabel.backgroundColor = UIColor.yellowColor()
        case 8:colorLabel.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.2, alpha: 1.0)
        case 9:colorLabel.backgroundColor = UIColor(red: 0.3, green: 0.2, blue: 0.2, alpha: 1.0)
        case 10:colorLabel.backgroundColor = UIColor(red: 0.5, green: 0.2, blue: 0.2, alpha: 1.0)
        case 11:colorLabel.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 1.0)
        case 12:colorLabel.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
        case 13:colorLabel.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.2, alpha: 1.0)
        case 14:colorLabel.backgroundColor = UIColor(red: 0.3, green: 0.4, blue: 0.2, alpha: 1.0)
        case 15:colorLabel.backgroundColor = UIColor(red: 0.7, green: 0.4, blue: 0.2, alpha: 1.0)
        case 16:colorLabel.backgroundColor = UIColor(red: 0.9, green: 0.4, blue: 0.2, alpha: 1.0)
        case 17:colorLabel.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.6, alpha: 1.0)
        case 18:colorLabel.backgroundColor = UIColor(red: 0.3, green: 0.4, blue: 0.6, alpha: 1.0)
        case 19:colorLabel.backgroundColor = UIColor(red: 0.5, green: 0.4, blue: 0.6, alpha: 1.0)
        case 20:colorLabel.backgroundColor = UIColor(red: 0.7, green: 0.4, blue: 0.6, alpha: 1.0)
        case 21:colorLabel.backgroundColor = UIColor(red: 0.9, green: 0.4, blue: 0.6, alpha: 1.0)
        case 22:colorLabel.backgroundColor = UIColor(red: 0.1, green: 0.8, blue: 0.6, alpha: 1.0)
        case 23:colorLabel.backgroundColor = UIColor(red: 0.5, green: 0.8, blue: 0.6, alpha: 1.0)
            
        default: println(0)
        }
    }
}