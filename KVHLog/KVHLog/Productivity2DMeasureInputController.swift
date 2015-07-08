

import UIKit
import Darwin
import SpriteKit

class Productivity2DMeasureInputController: UIViewController {

    
    @IBAction func nextDay(sender: AnyObject) {
        choosenDay = choosenDay.dateByAddingTimeInterval(24 * 60 * 60)
        choosenDayOn++
        viewDidLoad()
    }
    
    @IBAction func previousDay(sender: AnyObject) {
        choosenDay = choosenDay.dateByAddingTimeInterval(-24 * 60 * 60)
        choosenDayOn--
        viewDidLoad()
    }
    
    var choosenDayOn = 10000
    @IBOutlet weak var choosenDayLabel: UILabel!
    var index = 0
    var circle = UIView()
    
    var choosenDay = NSDate()
    
    //MARK: - Life Cycle
    var ind = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var x1:Float = 190.0
        var y1:Float = 390.0
        
        var backButton = UIBarButtonItem(title: "キャンセル", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        if ind {
            switch index {
            case 1:choosenDay = choosenDay.dateByAddingTimeInterval(-24*60*60)
                choosenDayOn--
            case 2:choosenDay = choosenDay.dateByAddingTimeInterval(-2*24*60*60)
                choosenDayOn-=2
            case 3:choosenDay = choosenDay.dateByAddingTimeInterval(-3*24*60*60)
                choosenDayOn-=3
            case 4:choosenDay = choosenDay.dateByAddingTimeInterval(-4*24*60*60)
                choosenDayOn-=4
            case 5:choosenDay = choosenDay.dateByAddingTimeInterval(-5*24*60*60)
                choosenDayOn-=5
            case 6:choosenDay = choosenDay.dateByAddingTimeInterval(-6*24*60*60)
                choosenDayOn-=6
            default: println(0)
            }
            ind = false
        }
        
        
        
        
        if choosenDayOn < 10000 {
            
            println("name")
            
            circle.frame = CGRectMake(200, 200, 40, 40)
            circle.layer.cornerRadius = 20.0
            circle.layer.borderColor = UIColor.greenColor().CGColor
            circle.layer.borderWidth = 2
            circle.clipsToBounds = true
//            circle.backgroundColor = UIColor.blackColor()
            self.view.addSubview(circle)
            
         //   circle.alpha = 1.0
        }
        else {
            println(choosenDayOn)
            circle.removeFromSuperview()
        }
        
        let calendars = Calendar()
        
        choosenDayLabel.text = "\(calendars.myYear(choosenDay)) / \(calendars.myMonth(choosenDay)) / \(calendars.myDay(choosenDay))"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch:AnyObject in touches {
            let point = touch.locationInView(self.view)
            let pointX = point.x
            let pointY = point.y
            println("\(pointX) , \(pointY)")
            if pointX > 140 && pointX < 220 && pointY < 360 && pointY > 280 {
                println("E")
                showToNext()
            }
            else {
                if(pointX > 60 && pointX < 300 && pointY > 200 && pointY < 440) {
                if(pointX < 180 && pointY < 320) {
                    println("A")
                }
                if(pointX < 180 && pointY > 320) {
                    println("C")
                }
                if(pointX > 180 && pointY < 320) {
                    println("B")
                }
                if(pointX > 180 && pointY > 320) {
                    println("D")
                }
                    showToNext()
                    
                }
                else
                {
                    println("seni")
                }
            }
        }
    }
    
    func showToNext(){
        var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var productivityExaminationInputController = storyboard.instantiateViewControllerWithIdentifier("ProductivityExaminationInputController") as! ProductivityExaminationInputController
        
        self.navigationController?.pushViewController(productivityExaminationInputController, animated: true)
    }
}
