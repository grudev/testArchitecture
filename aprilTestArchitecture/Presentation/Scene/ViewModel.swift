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
    
    private (set) var output = ViewController.Output()
    
    // MARK: - Observable
    private var disposal = Disposal()
    
    init(_ uc: DataUseCase) {
        self.useCase = uc
    }
    
    func getData(_ request: DataRequest) {
        observeLoading.wrappedValue = true
        
        useCase.executeAsync(request).observe { [weak self] (newValue, oldValue) in
            self?.output.dataSource.wrappedValue = newValue
            self?.observeLoading.wrappedValue = false
        }.add(to: &disposal)
        
    }
    
}

// MARK: - Input

extension ViewController {
    struct Input { }
}

// MARK: - Output

extension ViewController {
    struct Output {
        typealias Output = Result<[DataResponse], ErrorModel>
        var dataSource: MutableObservable<Output> = MutableObservable(wrappedValue: Result.failure(empty))
    }
}
