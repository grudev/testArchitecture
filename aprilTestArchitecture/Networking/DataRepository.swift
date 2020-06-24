//
//  DataRepository.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 23.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation

protocol DataRepository {
    func getData(_ request: DataRequest) -> MutableObservable<Result<[DataResponse], ErrorModel>>
}
