
import UIKit
import CoreData

class ActivityAdditionController: UIViewController, ColorSettingDelegate,CategorySettingDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var activityField: UITextField!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var categoryField: UITextField!
    var colorSettingController:ColorSettingController!
    var showCategorySettingController:CategorySettingController!
    var m_activity:M_activity!
    var indexPath:NSIndexPath!
    
    func didPushRegisterButtonItem(){
        
        let request = NSFetchRequest(entityName: "M_activity")
        var error: NSError? = nil
        
        var className:String = "M_activity"
        let myEntity: NSEntityDescription! = NSEntityDescription.entityForName(className, inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
        m_activity = M_activity(entity: myEntity, insertIntoManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        
        m_activity.activity = activityField.text
        m_activity.color = indexPath != nil ? indexPath.row : 1
      //  m_activity.color = indexPath.row
        m_activity.category = categoryField.text
        m_activity.created = NSDate()
        
        CoreDataManager.sharedInstance.saveContext()
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
    }
    
    //MARK: - UIBarbuttonItem Event Handler
    
    func didPushCancelButtonItem(){
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
    }
    
    //MARK: - View LifeCycle
    
    override func viewDidLoad() {
        
        var registerItemButton = UIBarButtonItem(title: "登録", style: UIBarButtonItemStyle.Plain, target: self, action: "didPushRegisterButtonItem")
        navigationItem.rightBarButtonItem = registerItemButton
        
        
        var cancelItemButton = UIBarButtonItem(title: "キャンセル", style: UIBarButtonItemStyle.Plain, target: self, action: "didPushCancelButtonItem")
        navigationItem.leftBarButtonItem = cancelItemButton
        
        
        
        
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
        }else if segue.identifier == "ShowCategorySetting" {
            showCategorySettingController = segue.destinationViewController as! CategorySettingController
            showCategorySettingController.delegate = self
        }
    }
    
    func getSelectedCategory(name:String)
     {
        categoryField.text = name
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
         self.view.endEditing(true)
        return true
    }
    
    //MARK: - ColorSettingDelegate
    
    func getSelectedColor(indexPath: NSIndexPath) {
        self.indexPath = indexPath
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