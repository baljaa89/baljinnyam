
import UIKit
import CoreData

class ExaminationView: UIView {
    var calendar = Calendar()
    let productivity = Productivity.sharedInstance.productivityCalculator()
    var kvhLabel:UILabel!
    override func awakeFromNib() {
        
        let kvhLabel = self.viewWithTag(2) as! UILabel
        let conditionLabel = self.viewWithTag(3) as! UILabel
        let commentLabel = self.viewWithTag(4) as! UILabel
        kvhLabel.text = getT_productivityData() == 1 ? "0kvhです" : "\(getT_productivityData()) kvh です！"
        conditionLabel.text = "絶好調！"
        commentLabel.text = "ノーストレスの達人です！"
    }
    
    //MARK: - CoreData Fetch
    
    func getT_productivityData() -> Int32{
        let request = NSFetchRequest(entityName: "T_productivity")
        var error: NSError? = nil
        let results:[T_productivity] = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error) as! [T_productivity]
        
        var choosenDay = NSDate()
        for t_productivity in results {
            if calendar.myYear(choosenDay) == calendar.myYear(t_productivity.dateTime) && calendar.myMonth(choosenDay) == calendar.myMonth(t_productivity.dateTime) && calendar.myDay(choosenDay) == calendar.myDay(t_productivity.dateTime){
                return t_productivity.productivity.intValue
            }
            
        }
        return 1
    }
}
