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
            guard let repo = resolver.resolve(DataRepository.self, name: RepoInjectionType.real),
                let cacheRepo = resolver.resolve(DataRepository.self, name: RepoInjectionType.cache) else {
                    fatalError("ERROR: UseCaseAssembly :: Missing dependency!")
            }
            return DataUseCase(repo, cacheRepo)
        }
        
    }
    
}
