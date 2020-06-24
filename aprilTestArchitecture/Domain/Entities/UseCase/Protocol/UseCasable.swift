//
//  UseCasable.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 24.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation

protocol UseCaseable {
    
    associatedtype Input
    associatedtype Output
    
    func execute(_ input: Input) -> Observable<Output>
    func executeAsync(_ input: Input) -> Observable<Output>
    
    func run(_ input: Input) -> Observable<Output>
    
}

extension UseCaseable {
    
    func execute(_ input: Input) -> Observable<Output> {
        DispatchQueue.main.sync {
            return run(input)
        }
    }
    
    func executeAsync(_ input: Input) -> Observable<Output> {
        DispatchQueue.global(qos: .userInitiated).sync {
            return run(input)
        }
    }
    
}

struct RepoInjectionType {
    static let real = "real"
    static let cache = "cache"
    static let realMock = "real"
    static let cacheMock = "cache"
}
