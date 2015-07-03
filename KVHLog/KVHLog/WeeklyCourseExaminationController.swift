

import UIKit

class WeeklyCourseExaminationController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var thisWeekLabel: UILabel!
    var week:[String] = ["今日","木","水","火","月","日","土"]
    var today = NSDate()
    let productivity = Productivity.sharedInstance.productivityCalculator()
    var examination:[String] = ["飲酒：お酒でストレス解消","飲酒：どうも飲みすぎた","飲酒：どうも飲みすぎた","飲酒：どうも飲みすぎた","","飲酒：どうも飲みすぎた","飲酒：どうも飲みすぎた"]
    var stepsCountWeek:[Int] = [0,0,0,0,0,0,0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var backButton = UIBarButtonItem(title: "戻る", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StepsCountCell", forIndexPath: indexPath) as! UITableViewCell
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath){
            var calendars = CalendarController()
            switch calendars.myWeekday(today) {
            case 1: week[1] = "土"
            week[2] = "金"
            week[3] = "木"
            week[4] = "水"
            week[5] = "火"
            week[6] = "月"
            case 2: week[1] = "日"
            week[2] = "土"
            week[3] = "金"
            week[4] = "木"
            week[5] = "水"
            week[6] = "火"
            case 3:
                week[1] = "月"
                week[2] = "日"
                week[3] = "土"
                week[4] = "金"
                week[5] = "木"
                week[6] = "水"
            case 4:
                week[1] = "火"
                week[2] = "月"
                week[3] = "日"
                week[4] = "土"
                week[5] = "金"
                week[6] = "木"
            case 5:
                week[1] = "水"
                week[2] = "火"
                week[3] = "月"
                week[4] = "日"
                week[5] = "土"
                week[6] = "金"
            case 6:
                week[1] = "木"
                week[2] = "水"
                week[3] = "火"
                week[4] = "月"
                week[5] = "日"
                week[6] = "土"
            case 7:
                week[1] = "金"
                week[2] = "木"
                week[3] = "水"
                week[4] = "火"
                week[5] = "月"
                week[6] = "日"
            default: print(0)
            }
            
            
            let weekDay = cell.contentView.viewWithTag(1) as! UILabel
            weekDay.text = week[indexPath.row]
            
            
            //            dashBoard.initialPro()
            for index in 0...6 {
                stepsCountWeek[index] = productivity[10000-index]
            }
            var weekTotal = 0
            for index in 0...6 {
                weekTotal = weekTotal+stepsCountWeek[index]
            }
            thisWeekLabel.text = "\(weekTotal)kvh"
            let stepsCount = cell.contentView.viewWithTag(2) as! UILabel
            stepsCount.text = examination[indexPath.row]
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "productivity2D"  {
            
            let productivity2D = segue.destinationViewController as! Productivity2DMeasureInputController
            //   dailyCourseCalendar.choosenDay =
            let indexPath = tableView.indexPathForSelectedRow()?.row
            productivity2D.index = indexPath!
            
        }
    }

}
