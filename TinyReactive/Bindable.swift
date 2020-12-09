//
//  Bindable.swift
//  TinyReactive
//
//  Created by Abraham Gonzalez on 12/5/20.
//

import Foundation

// Note: Publishers are not thread safe
public class Bindable<Value> {
    public typealias EventHandler = (Value) -> Void
    private var observations = [UUID: EventHandler]()
    public private(set) var lastValue: Value
    
    public init(_ value: Value) {
        lastValue = value
    }
    
    @discardableResult
    public func observe<Observer: AnyObject>(_ observer: Observer,
                                             closure: @escaping (Observer, Value) -> Void) -> ObservationToken {
        // If we already have a value available, we'll give the
        // handler access to it directly.
        closure(observer, lastValue)
        
        let id = UUID()
        observations[id] = { [weak self, weak observer] data in
            guard let observer = observer else {
                self?.observations.removeValue(forKey: id)
                return
            }
            
            closure(observer, data)
        }
        return ObservationToken { [weak self] in
            self?.observations.removeValue(forKey: id)
        }
    }
    
    fileprivate func raise(data: Value) {
        lastValue = data
        observations.values.forEach { closure in
            closure(data)
        }
    }
    
    @discardableResult
    public func bind<Observer: AnyObject, T>(_ sourceKeyPath: KeyPath<Value, T>,
                                             to object: Observer,
                                             _ objectKeyPath: ReferenceWritableKeyPath<Observer, T>) -> ObservationToken {
        return observe(object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = value
        }
    }
    
    @discardableResult
    public func bind<Observer: AnyObject, T>(_ sourceKeyPath: KeyPath<Value, T>,
                                             to object: Observer,
                                             _ objectKeyPath: ReferenceWritableKeyPath<Observer, T?>) -> ObservationToken {
        return observe(object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = value
        }
    }
}

@propertyWrapper
public class Driver<Value> {
    public var wrappedValue: Value {
        get {
            
        }
        set {
            
        }
    }
}
