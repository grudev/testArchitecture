//
//  ErrorModel.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 23.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation

struct ErrorModel: Codable, Error {
    
    var message: String
    var code: Int
    
}

let empty = ErrorModel(message: "Empty", code: -100)
