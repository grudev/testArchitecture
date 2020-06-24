//
//  ViewControllerAssembly.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 24.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation
import Swinject

class ViewControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(ViewController.self) { resolver -> ViewController in
            guard let viewModel = resolver.resolve(ViewModel.self) else {
                fatalError("ERROR: ViewControllerAssembly :: Missing dependency!")
            }
            let viewController = UIStoryboard.main.instantiateViewController(ViewController.self)
            viewController.viewModel = viewModel
            return viewController
        }
        
    }
    
}
