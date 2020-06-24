//
//  UseCaseAssembly.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 24.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation
import Swinject

class UseCaseAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(DataUseCase.self) { resolver -> DataUseCase in
            guard let repo = resolver.resolve(DataRepository.self),
                let cacheRepo = resolver.resolve(DataCacheRepository.self) else {
                    fatalError("ERROR: UseCaseAssembly :: Missing dependency!")
            }
            return DataUseCase(repo, cacheRepository: cacheRepo)
        }
        
    }
    
}
