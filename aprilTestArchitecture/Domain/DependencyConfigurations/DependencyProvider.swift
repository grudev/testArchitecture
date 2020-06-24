//
//  DependencyProvider.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 24.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation
import Swinject

class DependencyProvider {
    
    static let shared = DependencyProvider()
    
    let container = Container()
    let assembler: Assembler

    private init() {
        
        // Add from higher to low in the array
        let assemblies: [Assembly] = [
            RepositoryAssembly(),
            UseCaseAssembly(),
            ViewModelAssembly(),
            ViewControllerAssembly()
        ]
        
        assembler = Assembler(assemblies, container: container)
        
    }
    
}

// MARK: - Custom object scope for our dependancies
extension ObjectScope {
    static let discardedWhenLogout = ObjectScope(
        storageFactory: PermanentStorage.init,
        description: "discardedWhenLogout"
    )
}
