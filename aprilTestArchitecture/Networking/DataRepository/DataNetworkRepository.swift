//
//  DataNetworkRepository.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 24.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation

class DataNetworkRepository: DataRepository {
    
    typealias Output = Result<[DataResponse], ErrorModel>
    
    // MARK: - Observable
    private let dataSubject: MutableObservable<Output> = MutableObservable(wrappedValue: Result.failure(empty))
    
    func getData(_ request: DataRequest) -> Observable<Output> {
        
        // Call Network Layer
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            
            var response = [DataResponse]()
            for index in 0...request.numberOfItems-1 {
                let newItem = DataResponse(id: "11111", name: "Test Name Network \(index)", someValue: Int.random(in: 0...100))
                response.append(newItem)
            }
            self?.dataSubject.wrappedValue = Result.success(response)
            
        }
        
        return dataSubject
    }
    
}
