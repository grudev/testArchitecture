//
//  DataCacheRepository.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 24.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation

protocol DataCacheRepository {
    
    // NOTE: - Can't set associated types to this protocol because this will require the parent class (the UseCase object) to pass these as generic types.
    // Thus, this will create deep generic passing
//        associatedtype Input
//        associatedtype Output
        
    func getData(_ request: DataRequest) -> Observable<Result<[DataResponse], ErrorModel>>
}
