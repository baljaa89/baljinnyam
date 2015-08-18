import UIKit
import CoreData
import Parse
import JavaScriptCore

class DetailSettingController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var dateArray:[NSDate] = []
    
    //読み込み用の配列
    var getDateArray:[M_notification] = []
    
    @IBAction func didPushRegisterButton(sender: AnyObject) {
        sendingNotification()
        
        if notificationField.text != "" {
            dateArray.append(dateFormatter.dateFromString(notificationField.text)!)
        }
        if notificationField2.text != "" {
            dateArray.append(dateFormatter.dateFromString(notificationField2.text)!)
        }
        if notificationField3.text != "" {
            dateArray.append(dateFormatter.dateFromString(notificationField3.text)!)
        }
        if notificationField4.text != "" {
            dateArray.append(dateFormatter.dateFromString(notificationField4.text)!)
        }
        if notificationField5.text != "" {
            dateArray.append(dateFormatter.dateFromString(notificationField5.text)!)
        }
        
        
        let request = NSFetchRequest(entityName: "M_notification")
        var error: NSError? = nil
        var className:String = "M_notification"
        
        if let results = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) {
            for result in results {
                CoreDataManager.sharedInstance.managedObjectContext!.deleteObject(result as! NSManagedObject)
            }
        }
        
        for date in dateArray{
            
            let myEntity: NSEntityDescription! = NSEntityDescription.entityForName(className, inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
            let m_notification = M_notification(entity: myEntity, insertIntoManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
            
            m_notification.notify_time = date
            m_notification.created = NSDate()
            m_notification.created_by = "dfdsfsf"
            m_notification.modified = NSDate()
            m_notification.modified_by = "fdsfda"
            
            var weekDay:Int = weekStartField.text == "月曜日" ? 2 : 1
            m_notification.weekstart = NSNumber(integer: weekDay)
            
            CoreDataManager.sharedInstance.saveContext()
            
        }
        
        if dateArray.count == 0{
            if notificationField.text != "" {
                dateArray.append(dateFormatter.dateFromString(notificationField.text)!)
            }
            let myEntity: NSEntityDescription! = NSEntityDescription.entityForName(className, inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
            let m_notification = M_notification(entity: myEntity, insertIntoManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext)
            m_notification.notify_time = NSDate()
            m_notification.created = NSDate()
            m_notification.created_by = "dfdsfsf"
            m_notification.modified = NSDate()
            m_notification.modified_by = "fdsfda"
            
            var weekDay:Int = weekStartField.text == "月曜日" ? 2 : 1
            m_notification.weekstart = NSNumber(integer: weekDay)
            
            CoreDataManager.sharedInstance.saveContext()
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func notificationTimeRemove(sender: AnyObject) {
        switch sender.tag {
        case 6: notificationField.text = ""
        case 7: notificationField2.text = ""
        case 8: notificationField3.text = ""
        case 9: notificationField4.text = ""
        case 10: notificationField5.text = ""
        default:println()
        }
    }
    
    let dateFormatter = NSDateFormatter()
    var weekStartMassive = ["月曜日","日曜日"]
    @IBOutlet weak var notificationField: UITextField!
    @IBOutlet weak var notificationField2: UITextField!
    @IBOutlet weak var notificationField3: UITextField!
    @IBOutlet weak var notificationField4: UITextField!
    @IBOutlet weak var notificationField5: UITextField!
    
    @IBOutlet weak var weekStartField: UITextField!
    
    //MARK: - View LifeCycle
    
    override func viewDidLoad() {
        weekStartField.text = "月曜日"
        getM_notificationData()
        
        super.viewDidLoad()
        var toolBar:UIToolbar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.Default
        toolBar.sizeToFit()
        
        var spacer:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        var commitButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "closeKeyboard:")
        let toolBarItems = [spacer,commitButton]
        toolBar.setItems(toolBarItems, animated: true)
        
        
        dateFormatter.dateFormat = "HH:mm"
        switch getDateArray.count {
        case 1:notificationField.text = dateFormatter.stringFromDate(getDateArray[0].notify_time)
        case 2:
                notificationField.text = dateFormatter.stringFromDate(getDateArray[0].notify_time)
                notificationField2.text = dateFormatter.stringFromDate(getDateArray[1].notify_time)
        case 3:
                notificationField.text = dateFormatter.stringFromDate(getDateArray[0].notify_time)
                notificationField2.text = dateFormatter.stringFromDate(getDateArray[1].notify_time)
                notificationField3.text = dateFormatter.stringFromDate(getDateArray[2].notify_time)
        case 4:
                notificationField.text = dateFormatter.stringFromDate(getDateArray[0].notify_time)
                notificationField2.text = dateFormatter.stringFromDate(getDateArray[1].notify_time)
                notificationField3.text = dateFormatter.stringFromDate(getDateArray[2].notify_time)
                notificationField4.text = dateFormatter.stringFromDate(getDateArray[3].notify_time)
        case 5:
                notificationField.text = dateFormatter.stringFromDate(getDateArray[0].notify_time)
                notificationField2.text = dateFormatter.stringFromDate(getDateArray[1].notify_time)
                notificationField3.text = dateFormatter.stringFromDate(getDateArray[2].notify_time)
                notificationField4.text = dateFormatter.stringFromDate(getDateArray[3].notify_time)
                notificationField5.text = dateFormatter.stringFromDate(getDateArray[4].notify_time)
        default: println()
        
        }
        
        
        var datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Time
        datePicker.setDate(dateFormatter.dateFromString("00:00")!, animated: true)
        
        notificationField.inputView = datePicker
        notificationField.inputAccessoryView = toolBar
        notificationField.placeholder = "時間を選択してください"
        
        datePicker.addTarget(self, action: Selector("handleBirthdayPicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
        var datePicker2:UIDatePicker = UIDatePicker()
        datePicker2.datePickerMode = UIDatePickerMode.Time
        datePicker2.setDate(dateFormatter.dateFromString("00:00")!, animated: true)
        
        notificationField2.inputView = datePicker2
        notificationField2.inputAccessoryView = toolBar
        notificationField2.placeholder = "時間を選択してください"
        
        datePicker2.addTarget(self, action: Selector("handleBirthdayPicker2:"), forControlEvents: UIControlEvents.ValueChanged)
        
        var datePicker3:UIDatePicker = UIDatePicker()
        datePicker3.datePickerMode = UIDatePickerMode.Time
        datePicker3.setDate(dateFormatter.dateFromString("00:00")!, animated: true)
        
        notificationField3.inputView = datePicker3
        notificationField3.inputAccessoryView = toolBar
        notificationField3.placeholder = "時間を選択してください"
        
        datePicker3.addTarget(self, action: Selector("handleBirthdayPicker3:"), forControlEvents: UIControlEvents.ValueChanged)
        
        var datePicker4:UIDatePicker = UIDatePicker()
        datePicker4.datePickerMode = UIDatePickerMode.Time
        datePicker4.setDate(dateFormatter.dateFromString("00:00")!, animated: true)
        
        notificationField4.inputView = datePicker4
        notificationField4.inputAccessoryView = toolBar
        notificationField4.placeholder = "時間を選択してください"
        
        datePicker4.addTarget(self, action: Selector("handleBirthdayPicker4:"), forControlEvents: UIControlEvents.ValueChanged)
        
        var datePicker5:UIDatePicker = UIDatePicker()
        datePicker5.datePickerMode = UIDatePickerMode.Time
        datePicker5.setDate(dateFormatter.dateFromString("00:00")!, animated: true)
        
        notificationField5.inputView = datePicker5
        notificationField5.inputAccessoryView = toolBar
        notificationField5.placeholder = "時間を選択してください"
        
        datePicker5.addTarget(self, action: Selector("handleBirthdayPicker5:"), forControlEvents: UIControlEvents.ValueChanged)
  
        var genderPickerView = UIPickerView()
        genderPickerView.tag = 2
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
        weekStartField.inputView = genderPickerView
        
        weekStartField.inputAccessoryView = toolBar
        weekStartField.placeholder = "週始まりを設定してください"
    }
    
    //MARK: - CoreData Fetch
    
    
    func getM_notificationData(){
        let request = NSFetchRequest(entityName: "M_notification")
        let notify_time = NSSortDescriptor(key: "notify_time", ascending: true)
        request.sortDescriptors = [notify_time]
        var error: NSError? = nil
        let results: NSArray = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for m_notification in results {
            getDateArray.append(m_notification as! M_notification)
            if m_notification.weekstart.integerValue == 2{
                weekStartField.text = "月曜日"
            }
        }
    }
    
    

    
    //MARK: - UIPickerView Datasource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return 2
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return weekStartMassive[row] as String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weekStartField.text = weekStartMassive[row]
     
    }
    
    //MARK: - Event Handler
    
    
    
    
    
    
    
    
    func handleBirthdayPicker(sender:UIDatePicker){
        notificationField.text = dateFormatFunc(sender.date, style:"HH:mm")
    }
    
    func handleBirthdayPicker2(sender:UIDatePicker){
        notificationField2.text = dateFormatFunc(sender.date, style:"HH:mm")
        
    }
    
    func handleBirthdayPicker3(sender:UIDatePicker){
        notificationField3.text = dateFormatFunc(sender.date, style:"HH:mm")
    }
    
    
    func handleBirthdayPicker4(sender:UIDatePicker){
        notificationField4.text = dateFormatFunc(sender.date, style:"HH:mm")
    }
    
    func handleBirthdayPicker5(sender:UIDatePicker){
        notificationField5.text = dateFormatFunc(sender.date, style:"HH:mm")
    }
    
    
    func closeKeyboard(textView : UITextView){
        notificationField.resignFirstResponder()
        notificationField2.resignFirstResponder()
        notificationField3.resignFirstResponder()
        notificationField4.resignFirstResponder()
        notificationField5.resignFirstResponder()
        weekStartField.resignFirstResponder()
        }
    
    
    
    
    
    
    
    func dateFormatFunc(date:NSDate, style:String) -> String {
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = style
        return dateFormatter.stringFromDate(date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Push Notification
    
    func sendingNotification(){
        
//        let context = JSContext()
//        context.evaluateScript("Parse.Push.send({")
//     //   context.evaluateScript("where: query,")
//        context.evaluateScript("push_time: new Date(\"2015-08-11T23:00:00\"),")
//        context.evaluateScript("data: {")
//        context.evaluateScript("alert: \"Local push notification\"")
//        context.evaluateScript("}")
//        context.evaluateScript("}, {")
//        context.evaluateScript("success: function() {")
//        context.evaluateScript("console.log(\"Succesful push\");")
//        context.evaluateScript("},")
//        context.evaluateScript("error: function(error) {")
//        context.evaluateScript("console.log(error);")
//        context.evaluateScript("}")
//        context.evaluateScript("});")
     //   let tripleNum: JSValue = context.evaluateScript("triple(num)")
        
        
        
//        let ctx = JSContext()
//        var jsv = ctx.evaluateScript(
//            "var query = new Parse.Query(Parse.Installation); query.equalTo('user_id', 'user_123'); Parse.Push.send({where: query,data: {alert: \"You previously created a reminder for the game today\"},push_time: tomorrowDate}, {success: function() {// Push was successful},error: function(error) {// Handle error}});")
       
        let data = [
            "alert" : "The Mets scored! The game is now tied 1-1!",
            "badge" : "Increment",
            "sounds" : "ding.aiff"
        ]
        let push = PFPush()
//        push.setChannels(["Mets"])
    
        push.setData(data)
        push.sendPushInBackground()
        
        
        
        
    }

}
