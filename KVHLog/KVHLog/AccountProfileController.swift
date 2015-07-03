import UIKit

class AccountProfileController: UIViewController,UITextFieldDelegate, UIPickerViewDataSource,
UIPickerViewDelegate{
    
    let dateFormatter = NSDateFormatter()
    
    var myDate = NSDate()
    var sex = ["男","女"]
    var jobs = ["プログラマー","医者","調理師"]
    var jobStyle = ["プログラマー1","医者","調理師"]
    var jobSpecial = ["プログラマー2","医者","調理師"]
    var nationality = ["日本","アメリカ","カナダ","イギリス","ドイツ"]
    var isChild = ["子供いる","子供いない"]
    
    
    var region = ["東京","大阪","新潟","静岡","青森"]
    
    @IBOutlet weak var birthdayField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var jobField: UITextField!
    
    @IBOutlet weak var jobStyleField: UITextField!
    
    @IBOutlet weak var jobSpecialField: UITextField!
    
    @IBOutlet weak var regionField: UITextField!
    
    @IBOutlet weak var nationalityField: UITextField!
    
    @IBOutlet weak var isChildField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
}
