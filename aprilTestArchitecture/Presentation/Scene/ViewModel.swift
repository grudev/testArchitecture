//
//  ViewModel.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 23.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation

class ViewModel: BaseViewModel {
    
    private var useCase: DataUseCase
    
    // MARK: - Observable
    private var disposal = Disposal()
    
    typealias Output = (Result<[DataResponse], ErrorModel>)?
    private var privateDataSource: MutableObservable<Output> = MutableObservable(wrappedValue: nil)
    
    var dataSource: Observable<Output> {
        privateDataSource
    }
    
    init(_ uc: DataUseCase) {
        self.useCase = uc
    }
    
    func getData(_ request: DataRequest) {
        observeLoading.wrappedValue = true
        
        useCase.executeAsync(request).observe { [weak self] (newValue, _) in
            self?.privateDataSource.wrappedValue = newValue
            self?.observeLoading.wrappedValue = false
        }.add(to: &disposal)
        
    }
    
}
