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
    
    typealias CompletionHandler = ((_ output: Output) -> ())?
    
    // MARK: - Repository
    var userRepository: DataRepository
    var userCacheRepository: DataCacheRepository
    
    init(_ repository: DataRepository, cacheRepository: DataCacheRepository) {
        userRepository = repository
        userCacheRepository = cacheRepository
    }
    
    func run(_ input: Input) -> Observable<Output>  {
        let observable = userCacheRepository.getData(input)
        
        // TODO: - How to detect if cache is slower than actual request, that we don't have to update our Observable?
        let updateObservable = userRepository.getData(input)
        
        return observable
    }
    
}
