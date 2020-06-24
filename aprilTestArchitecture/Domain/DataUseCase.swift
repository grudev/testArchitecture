//
//  DataUseCase.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 23.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation

class DataUseCase: UseCaseable {

    typealias Input = DataRequest
    typealias Output = Result<[DataResponse], ErrorModel>
    
    // MARK: - Repository
    private var userRepository: DataRepository
    private var userCacheRepository: DataRepository
    
    init(_ repository: DataRepository, _ cacheRepository: DataRepository) {
        userRepository = repository
        userCacheRepository = cacheRepository
    }
    
    func run(_ input: Input) -> Observable<Output> {
        let observable = userCacheRepository.getData(input)
        
        userRepository.getData(input).observe { (newValue, oldValue) in
            observable.wrappedValue = newValue
        }
        
        return observable
    }
    
}
