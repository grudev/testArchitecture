//
//  RepositoryAssembly.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 24.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation
import Swinject

class RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(DataCacheRepository.self) { _ in
            DataLocalCacheRepository()
        }
        
        container.register(DataRepository.self) { _ in
            DataNetworkRepository()
        }
        
    }
    
}
