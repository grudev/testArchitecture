//
//  MainNavigationController.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 23.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import UIKit
import Swinject

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        guard let viewController = DependencyProvider.shared.container.resolve(ViewController.self) else {
            print("ERROR: MainNavigationController :: failed to push root view controller")
            return
        }
        pushViewController(viewController, animated: false)
        
    }
    
}
