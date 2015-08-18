import UIKit
import CoreData

class AccountProfileController: UIViewController,UITextFieldDelegate, UIPickerViewDataSource,
UIPickerViewDelegate,NSFetchedResultsControllerDelegate{
    
    let dateFormatter = NSDateFormatter()
    
    var myDate = NSDate()
    var sex = ["男","女"]
    var jobs = ["プログラマー","医者","調理師"]
    var jobStyle = ["プログラマー1","医者","調理師"]
    var jobSpecial = ["プログラマー2","医者","調理師"]
    var nationality = ["日本","アメリカ","カナダ","イギリス","ドイツ"]
    var isChild = ["子供いる","子供いない"]
    var region = ["東京","大阪","新潟","静岡","青森"]
    
    var isSaved:Bool = false
    var m_profile:M_profile!
    var defaultResults:[M_profile] = []
    
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    @IBOutlet weak var birthdayField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var jobField: UITextField!
    
    @IBOutlet weak var jobStyleField: UITextField!
    
    @IBOutlet weak var jobSpecialField: UITextField!
    
    @IBOutlet weak var regionField: UITextField!
    
    @IBOutlet weak var nationalityField: UITextField!
    
    @IBOutlet weak var isChildField: UITextField!

    @IBAction func didPushSaveButton(sender: AnyObject) {
        
        let request = NSFetchRequest(entityName: "M_profile")
        var error: NSError? = nil
        var className:String = "M_profile"
        
        if let results = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) {
            for result in results {
                CoreDataManager.sharedInstance.managedObjectContext!.deleteObject(result as! NSManagedObject)
            }
        }
        
        let myEntity: NSEntityDescription! = NSEntityDescription.entityForName(className, inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
        m_profile = M_profile(entity: myEntity, insertIntoManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
        
        m_profile.birthday = birthdayField.text
        m_profile.sex = genderField.text
        m_profile.industry = jobField.text
        m_profile.workstyle = jobStyleField.text
        m_profile.workcharacter = jobSpecialField.text
        m_profile.region = regionField.text
        m_profile.nationality = nationalityField.text
        m_profile.children = isChildField.text
        m_profile.created  = NSDate()
        m_profile.created_by = "dfasfds"
        m_profile.modified = NSDate()
        m_profile.modified_by = "dffdafds"
        
        CoreDataManager.sharedInstance.saveContext()

        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var fetchRequest = NSFetchRequest(entityName: "M_profile")
        let ruby = NSSortDescriptor(key: "birthday", ascending: true)
        fetchRequest.sortDescriptors = [ruby]
        
        if let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext {
            _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
            var error:NSError?
            var result = fetchedResultsController.performFetch(&error)
            defaultResults = fetchedResultsController.fetchedObjects as! [M_profile]
            if result != true {
                println(error?.localizedDescription)
            }
        }
        
        let today = NSDate()
       // birthdayField.text =
        var toolBar:UIToolbar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.Default
        toolBar.sizeToFit()
        
        var spacer:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        var commitButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "closeKeyboard:")
        let toolBarItems = [spacer,commitButton]
        toolBar.setItems(toolBarItems, animated: true)
        
        var datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        birthdayField.inputView = datePicker
        birthdayField.inputAccessoryView = toolBar
        datePicker.addTarget(self, action: Selector("handleBirthdayPicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
        var genderPickerView = UIPickerView()
        genderPickerView.tag = 2
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
        genderField.inputView = genderPickerView
        
        var jobPickerView = UIPickerView()
        jobPickerView.tag = 3
        jobPickerView.dataSource = self
        jobPickerView.delegate = self
        jobField.inputView = jobPickerView
        
        var jobStylePickerView = UIPickerView()
        jobStylePickerView.tag = 4
        jobStylePickerView.dataSource = self
        jobStylePickerView.delegate = self
        jobStyleField.inputView = jobStylePickerView
        
        var jobSpecialPickerView = UIPickerView()
        jobSpecialPickerView.tag = 5
        jobSpecialPickerView.dataSource = self
        jobSpecialPickerView.delegate = self
        jobSpecialField.inputView = jobSpecialPickerView
        
        var regionPickerView = UIPickerView()
        regionPickerView.tag = 6
        regionPickerView.dataSource = self
        regionPickerView.delegate = self
        regionField.inputView = regionPickerView
        
        var nationalityPickerView = UIPickerView()
        nationalityPickerView.tag = 7
        nationalityPickerView.dataSource = self
        nationalityPickerView.delegate = self
        nationalityField.inputView = nationalityPickerView
        
        var isChildPickerView = UIPickerView()
        isChildPickerView.tag = 8
        isChildPickerView.dataSource = self
        isChildPickerView.delegate = self
        isChildField.inputView = isChildPickerView
        
        getM_profileData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Data Fetch
    
    func getM_profileData(){
        let request = NSFetchRequest(entityName: "M_profile")
        var error: NSError? = nil
        let results: NSArray = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for item in results {
            var m_profile = item as! M_profile
            birthdayField.text = m_profile.birthday
            genderField.text = m_profile.sex
            jobField.text = m_profile.industry
            jobStyleField.text = m_profile.workstyle
            jobSpecialField.text = m_profile.workcharacter
            regionField.text = m_profile.region
            nationalityField.text = m_profile.nationality
            isChildField.text = m_profile.children
        }
    }
    
    func closeKeyboard(textView : UITextView){
        birthdayField.resignFirstResponder()
    }
    
    func dateFormatFunc(date:NSDate, style:String) -> String {
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = style
        return dateFormatter.stringFromDate(date)
    }
    
    //MARK: - Event Handler
    
    func handleBirthdayPicker(sender:UIDatePicker){
        birthdayField.text = dateFormatFunc(sender.date, style:"yyyy年MM月dd日")
    }
    
    //MARK: - UITextField Delegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField.tag {
        //case 10: birthdayField.text = "生年月日"
        case 11: genderField.text = "男"
       // case 12: jobField.text = "職種"
      //  case 13: jobStyleField.text = "働き方"
        default: println()
        }
    }
    
    //MARK: - UIPickerView Datasource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    
    
    /*
    
    pickerに表示する行数を返すデータソースメソッド.
    
    (実装必須)
    
    */
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        
        case 2: return sex.count
        case 3: return jobs.count
        case 4: return jobStyle.count
        case 5: return jobSpecial.count
        case 6: return region.count
        case 7: return nationality.count
        case 8: return isChild.count
        default: return 0
        }
        
    }
    
    
    
    /*
    
    pickerに表示する値を返すデリゲートメソッド.
    
    */
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        println(pickerView.tag)
        switch pickerView.tag {
        case 2: return sex[row] as String
        case 3: return jobs[row] as String
        case 4: return jobStyle[row] as String
        case 5: return jobSpecial[row] as String
        case 6: return region[row] as String
        case 7: return nationality[row] as String
        case 8: return isChild[row] as String
        default: return sex[row] as String
        }
        
    }
    
    
    
    /*
    
    pickerが選択された際に呼ばれるデリゲートメソッド.
    
    */
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 2: genderField.text = sex[row]
        case 3: jobField.text = jobs[row]
        case 4: jobStyleField.text = jobStyle[row]
        case 5: jobSpecialField.text = jobSpecial[row]
        case 6: regionField.text = region[row]
        case 7: nationalityField.text = nationality[row]
        case 8: isChildField.text = isChild[row]
        default: println(0)
        }
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch:AnyObject in touches {
            var touch2:UITouch = touch as! UITouch
            if touch2.view.tag == 1 {
                genderField.resignFirstResponder()
                jobField.resignFirstResponder()
                jobStyleField.resignFirstResponder()
                jobSpecialField.resignFirstResponder()
                regionField.resignFirstResponder()
                nationalityField.resignFirstResponder()
                isChildField.resignFirstResponder()
            }
        }
        
    }
    
    // MARK: - NSFetchedResultController
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let context: NSManagedObjectContext? = CoreDataManager.sharedInstance.managedObjectContext
        let name = NSSortDescriptor(key: "birthday", ascending: true)
        
        let request = NSFetchRequest(entityName: "M_profile")
        var error0:NSError?
        
        request.sortDescriptors = [name]
        request.returnsObjectsAsFaults = false
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        aFetchedResultsController.delegate = self
        
        _fetchedResultsController = aFetchedResultsController
        
        var error: NSError? = nil
        if !_fetchedResultsController!.performFetch(&error) {
            abort()
        }
        return _fetchedResultsController!
    }
}
