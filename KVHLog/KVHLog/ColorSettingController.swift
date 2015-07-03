

import UIKit

@objc protocol ColorSettingDelegate{
    func getSelectedColor(indexPath:NSIndexPath)
}

class ColorSettingController: UICollectionViewController {

    let cellMargin:CGFloat = 20.0
    var delegate:ColorSettingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let decideButtonItem = UIBarButtonItem(title: "決定", style: UIBarButtonItemStyle.Plain, target: self, action: "didPushDecideButtonItem")
        navigationItem.rightBarButtonItem = decideButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UICollectionView Datasource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 24
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell",
            forIndexPath: indexPath) as! UICollectionViewCell
        switch indexPath.row {
        case 0:cell.contentView.backgroundColor = UIColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        case 1:cell.contentView.backgroundColor = UIColor.redColor()
        case 2:cell.contentView.backgroundColor = UIColor.blueColor()
        case 3:cell.contentView.backgroundColor = UIColor.grayColor()
        case 4:cell.contentView.backgroundColor = UIColor.lightGrayColor()
        case 5:cell.contentView.backgroundColor = UIColor.greenColor()
        case 6:cell.contentView.backgroundColor = UIColor.orangeColor()
        case 7:cell.contentView.backgroundColor = UIColor.yellowColor()
        case 8:cell.contentView.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.2, alpha: 1.0)
        case 9:cell.contentView.backgroundColor = UIColor(red: 0.3, green: 0.2, blue: 0.2, alpha: 1.0)
        case 10:cell.contentView.backgroundColor = UIColor(red: 0.5, green: 0.2, blue: 0.2, alpha: 1.0)
        case 11:cell.contentView.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 1.0)
        case 12:cell.contentView.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
        case 13:cell.contentView.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.2, alpha: 1.0)
        case 14:cell.contentView.backgroundColor = UIColor(red: 0.3, green: 0.4, blue: 0.2, alpha: 1.0)
        case 15:cell.contentView.backgroundColor = UIColor(red: 0.7, green: 0.4, blue: 0.2, alpha: 1.0)
        case 16:cell.contentView.backgroundColor = UIColor(red: 0.9, green: 0.4, blue: 0.2, alpha: 1.0)
        case 17:cell.contentView.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.6, alpha: 1.0)
        case 18:cell.contentView.backgroundColor = UIColor(red: 0.3, green: 0.4, blue: 0.6, alpha: 1.0)
        case 19:cell.contentView.backgroundColor = UIColor(red: 0.5, green: 0.4, blue: 0.6, alpha: 1.0)
        case 20:cell.contentView.backgroundColor = UIColor(red: 0.7, green: 0.4, blue: 0.6, alpha: 1.0)
        case 21:cell.contentView.backgroundColor = UIColor(red: 0.9, green: 0.4, blue: 0.6, alpha: 1.0)
        case 22:cell.contentView.backgroundColor = UIColor(red: 0.1, green: 0.8, blue: 0.6, alpha: 1.0)
        case 23:cell.contentView.backgroundColor = UIColor(red: 0.5, green: 0.8, blue: 0.6, alpha: 1.0)
        default: println(0)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(50, 50, 50, 50)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
    
    //MARK: - UICollectionView Delegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell:UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.highlighted = true
    }
    
    override func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let  cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor.darkGrayColor()
    }
    
    override func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let  cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = nil
    }
    
    //MARK: - Event Handler
    
    func didPushDecideButtonItem(){
        let indexPaths : NSArray = self.collectionView!.indexPathsForSelectedItems()
        println(indexPaths)
        let indexPath : NSIndexPath = indexPaths[0] as! NSIndexPath
        println(indexPath)
        self.delegate?.getSelectedColor(indexPath)
        
        navigationController?.popViewControllerAnimated(true)
    }
}
