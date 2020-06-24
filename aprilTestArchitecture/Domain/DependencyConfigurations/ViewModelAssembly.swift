//
//  ViewModelAssembly.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 24.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(ViewModel.self) { resolver -> ViewModel in
            guard let useCase = resolver.resolve(DataUseCase.self) else {
                fatalError("ERROR: ViewModelAssembly :: Missing dependency!")
            }
            return ViewModel(useCase)
        }
        
    }
    
}
