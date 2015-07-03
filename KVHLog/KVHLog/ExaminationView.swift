
import UIKit

class ExaminationView: UIView {
    let productivity = Productivity.sharedInstance.productivityCalculator()
    override func awakeFromNib() {
        let kvhLabel = self.viewWithTag(2) as! UILabel
        let conditionLabel = self.viewWithTag(3) as! UILabel
        let commentLabel = self.viewWithTag(4) as! UILabel
        kvhLabel.text = "\(productivity[10000]) kvh です！"
        conditionLabel.text = "絶好調！"
        commentLabel.text = "ノーストレスの達人です！"
    }
}
