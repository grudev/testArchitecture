//
//  Disposable.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 23.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import Foundation

public typealias Disposal = [Disposable]

extension Disposal {
    public func dispose() {
        forEach { disposable in
            disposable.dispose()
        }
    }
}

public final class Disposable {
    
    public let dispose: () -> ()
    
    init(_ dispose: @escaping () -> ()) {
        self.dispose = dispose
    }
    
    deinit {
        dispose()
    }
    
    public func add(to disposal: inout Disposal) {
        disposal.append(self)
    }
}
