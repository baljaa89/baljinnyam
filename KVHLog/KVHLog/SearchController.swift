//
//  SearchController.swift
//  KVHLog
//
//  Created by baljinnyam on 2015/06/18.
//  Copyright (c) 2015年 baljinnyam. All rights reserved.
//

import UIKit

class SearchController: UISearchController {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(searchResultsController: UIViewController!) {
        super.init(searchResultsController: nil)
        
        self.searchBar.sizeToFit()
        self.searchBar.tintColor = UIColor.whiteColor()
        self.searchBar.placeholder = NSLocalizedString("Search your customer", comment: "Search your customer")
    }
}
