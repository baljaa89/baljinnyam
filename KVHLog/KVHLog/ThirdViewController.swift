//
//  ThirdViewController.swift
//  KVHLog
//
//  Created by baljinnyam on 2015/06/10.
//  Copyright (c) 2015年 baljinnyam. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        var backButton = UIBarButtonItem()
//        backButton.title = "戻る"
//        self.navigationItem.backBarButtonItem = backButton
        // Do any additional setup after loading the view.
        
        let backButton = UIBarButtonItem(title: "戻る", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
