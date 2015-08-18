import UIKit
import CoreData

class ActivitySelectedController: UITableViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,NSFetchedResultsControllerDelegate{
    
    var choosenDay:NSDate!
    var indexPath:NSIndexPath!
    var activityResults:[M_activity] = []
    var searchResults:[M_activity] = []
    
    let colorCategory:[M_activity] = []
    let colorCategory1:[M_activity] = []
    
    var searchController = UISearchController()
    var _fetchedResultsController: NSFetchedResultsController? = nil

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
        
        var fetchRequest = NSFetchRequest(entityName: "M_activity")
        let created = NSSortDescriptor(key: "created", ascending: true)
        fetchRequest.sortDescriptors = [created]
        
        if let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext {
            _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
            var error:NSError?
            var result = fetchedResultsController.performFetch(&error)
            activityResults = fetchedResultsController.fetchedObjects as! [M_activity]
            if result != true {
                println(error?.localizedDescription)
            }
        }

        println(activityResults)
        println(searchResults)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UISearchResultsUpdating
    
    func filterContentSearchText(searchText:String){
        searchResults = activityResults.filter({ ( m_activity: M_activity) -> Bool in
            let activitymatch = m_activity.activity.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let categoryMatch = m_activity.category.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return activitymatch != nil || categoryMatch != nil
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text
        filterContentSearchText(searchText)
        tableView.reloadData()
    }


    // MARK: - tableView datasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        if section == 0{
            return searchController.active ? searchResults.count : activityResults.count
        }else{
            return searchController.active ? searchResults.count : activityResults.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! UITableViewCell
        
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            
            let searchActivity = (searchController.active) ? searchResults[indexPath.row] : activityResults[indexPath.row]
            let searchActivity1 = (searchController.active) ? searchResults[indexPath.row] : activityResults[indexPath.row]
            
            if indexPath.section == 0{
                
                let colorLabel = cell.contentView.viewWithTag(1) as! UILabel
                colorLabel.backgroundColor = getColorByIndex(searchActivity.color)

                let mainLabel = cell.contentView.viewWithTag(2) as! UILabel
                mainLabel.text = searchActivity.activity
                
                let subLabel = cell.contentView.viewWithTag(3) as! UILabel
                subLabel.text = searchActivity1.category
            }
            else {
                let colorLabel = cell.contentView.viewWithTag(1) as! UILabel
                colorLabel.backgroundColor = getColorByIndex(searchActivity.color)
                
                let mainLabel = cell.contentView.viewWithTag(2) as! UILabel
                mainLabel.text = searchActivity.activity
                
                let subLabel = cell.contentView.viewWithTag(3) as! UILabel
                subLabel.text = searchActivity1.category
            }
    }
    
    func getColorByIndex(index:NSNumber) -> UIColor {
        switch index {
        case 0:  return UIColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        case 1:return UIColor.redColor()
        case 2:return UIColor.blueColor()
        case 3:return UIColor.grayColor()
        case 4:return UIColor.lightGrayColor()
        case 5:return UIColor.greenColor()
        case 6:return UIColor.orangeColor()
        case 7:return UIColor.yellowColor()
        case 8:return UIColor(red: 0.1, green: 0.2, blue: 0.2, alpha: 1.0)
        case 9:return UIColor(red: 0.3, green: 0.2, blue: 0.2, alpha: 1.0)
        case 10:return UIColor(red: 0.5, green: 0.2, blue: 0.2, alpha: 1.0)
        case 11:return UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 1.0)
        case 12:return UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
        case 13:return UIColor(red: 0.1, green: 0.4, blue: 0.2, alpha: 1.0)
        case 14:return UIColor(red: 0.3, green: 0.4, blue: 0.2, alpha: 1.0)
        case 15:return UIColor(red: 0.7, green: 0.4, blue: 0.2, alpha: 1.0)
        case 16:return UIColor(red: 0.9, green: 0.4, blue: 0.2, alpha: 1.0)
        case 17:return UIColor(red: 0.1, green: 0.4, blue: 0.6, alpha: 1.0)
        case 18:return UIColor(red: 0.3, green: 0.4, blue: 0.6, alpha: 1.0)
        case 19:return UIColor(red: 0.5, green: 0.4, blue: 0.6, alpha: 1.0)
        case 20:return UIColor(red: 0.7, green: 0.4, blue: 0.6, alpha: 1.0)
        case 21:return UIColor(red: 0.9, green: 0.4, blue: 0.6, alpha: 1.0)
        case 22:return UIColor(red: 0.1, green: 0.8, blue: 0.6, alpha: 1.0)
        case 23:return UIColor(red: 0.5, green: 0.8, blue: 0.6, alpha: 1.0)
            
        default: println(0)
        }
        return UIColor.greenColor()
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
    
    // MARK: - NSFetchedResultController
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let context: NSManagedObjectContext? = CoreDataManager.sharedInstance.managedObjectContext
        let created = NSSortDescriptor(key: "created", ascending: true)
        
        let request = NSFetchRequest(entityName: "M_activity")
        
        request.sortDescriptors = [created]
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
    
    // MARK: - NSFetchedResultController Delegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController,
        didChangeObject object: AnyObject,
        atIndexPath indexPath: NSIndexPath?,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath?) {
            
            switch type {
            case .Insert:
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Update:
                let cell = self.tableView.cellForRowAtIndexPath(indexPath!)
                self.configureCell(cell!, atIndexPath: indexPath!)
                self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Move:
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            default:
                return
            }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    //MARK: - UIStoryBoard Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowActivityTimeInput" {
            let activityTimeInputController = segue.destinationViewController as! ActivityTimeInputController
            let indexPath1 = tableView.indexPathForSelectedRow()?.row
            activityTimeInputController.activityResults = activityResults[indexPath1!].activity
            activityTimeInputController.categoryResults = activityResults[indexPath1!].category
            activityTimeInputController.indexPath = indexPath
            activityTimeInputController.choosenDay = choosenDay
        }
    }
}
