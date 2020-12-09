//
//  UtilityExtensions.swift
//  TinyReactive
//
//  Created by Abraham Gonzalez on 12/5/20.
//

import Foundation

internal extension Dictionary where Key == UUID {
    mutating func insert(_ value: Value) -> UUID {
        let id = UUID()
        self[id] = value
        return id
    }
}
