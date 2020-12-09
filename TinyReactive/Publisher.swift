//
//  Publisher.swift
//  TinyReactive
//
//  Created by Abraham Gonzalez on 12/5/20.
//

import Foundation

// Note: Publishers are not thread safe
public class Publisher<T>: Signal<T> {
    public typealias EventHandler = (T) -> Void
    private var observations = [UUID: EventHandler]()
    
    public override init() {
        super.init()
    }
    
    @discardableResult
    public override func observe<Observer: AnyObject>(_ observer: Observer,
                                           closure: @escaping (Observer, T) -> Void) -> ObservationToken {
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
    
    public func raise(data: T) {
        observations.values.forEach { closure in
            closure(data)
        }
    }
}
