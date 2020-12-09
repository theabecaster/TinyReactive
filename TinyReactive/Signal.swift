//
//  Signal.swift
//  TinyReactive
//
//  Created by Abraham Gonzalez on 12/5/20.
//

import Foundation

public class Signal<T> {
    public init() {}
    
    @discardableResult
    public func observe<Observer: AnyObject>(_ observer: Observer,
                                             closure: @escaping (Observer, T) -> Void) -> ObservationToken {
        return ObservationToken { }
    }
}
