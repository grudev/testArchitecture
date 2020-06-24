//
//  DataRequest.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 23.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation

struct DataRequest: Codable {
    var numberOfItems: Int
    var filter: String?
}
