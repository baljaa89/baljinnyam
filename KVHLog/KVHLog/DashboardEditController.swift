

import UIKit

class DashboardEditController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBAction func nextDay(sender: AnyObject) {
    }
    @IBAction func previousDay(sender: AnyObject) {
    }
    @IBOutlet weak var choosenDay: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    // MARK: - UITableViewDataSource
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DashboardEditCell", forIndexPath: indexPath) as! UITableViewCell
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath){
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 123
    }
}
