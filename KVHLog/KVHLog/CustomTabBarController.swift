//
//  CustomTabBarController.swift
//  KVHLog
//
//  Created by baljinnyam on 2015/06/13.
//  Copyright (c) 2015年 baljinnyam. All rights reserved.
//

import UIKit

protocol CustomTabBarControllerDelegate{
    func didSelect(customBarController:CustomTabBarController)
}

class CustomTabBarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
    }
}
