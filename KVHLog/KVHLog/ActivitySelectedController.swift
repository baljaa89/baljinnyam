import UIKit

class ActivitySelectedController: UITableViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating{
    
    let defaultData = ["One","Two","Three","Twenty-One"]
    let subCategory = ["映画","name","number","alpha"]
    let defaultData1 = ["On","Tw","Three","Twenty-One","On","Tw","Three","Twenty-One"]
    let subCategory1 = ["映画1","name1","number1","alpha1","映画1","name1","number1","alpha1"]
    let colorCategory = [UIColor.yellowColor(),UIColor.yellowColor(),UIColor.yellowColor(),UIColor.greenColor()]
    let colorCategory1 = [UIColor.yellowColor(),UIColor.yellowColor(),UIColor.yellowColor(),UIColor.greenColor(),UIColor.yellowColor(),UIColor.yellowColor(),UIColor.yellowColor(),UIColor.greenColor()]
    var searchResults = [String]()
    
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        var backButton = UIBarButtonItem(title: "キャンセル", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "検索"
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        let searchActivity = SearchActivity()
        var resultString = searchActivity.activityResult()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchResults.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
        let array = (defaultData as NSArray).filteredArrayUsingPredicate(searchPredicate)
        searchResults = array as! [String]
        
        self.tableView.reloadData()
    }


    // MARK: - tableView datasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        if section == 0{
            return searchController.active ? searchResults.count : defaultData.count
        }else{
            return searchController.active ? searchResults.count : defaultData1.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! UITableViewCell
        
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            if indexPath.section == 0{
                
                let colorLabel = cell.contentView.viewWithTag(1) as! UILabel
                colorLabel.backgroundColor = colorCategory[indexPath.row]
                
                let searchActivity = (searchController.active) ? searchResults[indexPath.row] : defaultData[indexPath.row]
//                cell.textLabel?.text = searchActivity
//                cell.detailTextLabel?.textColor = UIColor.grayColor()
                let mainLabel = cell.contentView.viewWithTag(2) as! UILabel
                mainLabel.text = searchActivity
                
                
                let searchActivity1 = (searchController.active) ? searchResults[indexPath.row] : subCategory[indexPath.row]
                
                let subLabel = cell.contentView.viewWithTag(3) as! UILabel
                subLabel.text = searchActivity1
            }
            else {
                let colorLabel1 = cell.contentView.viewWithTag(1) as! UILabel
                colorLabel1.backgroundColor = colorCategory1[indexPath.row]
                
                let searchActivity = (searchController.active) ? searchResults[indexPath.row] : defaultData1[indexPath.row]
                let mainLabel = cell.contentView.viewWithTag(2) as! UILabel
                mainLabel.text = searchActivity
                
                
                let searchActivity1 = (searchController.active) ? searchResults[indexPath.row] : subCategory1[indexPath.row]
                
                let subLabel = cell.contentView.viewWithTag(3) as! UILabel
                subLabel.text = searchActivity1
            }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "最近10件"
        }
        else
        {
            return "全件"
        }
    }
    
    // MARK: - UITableView Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
