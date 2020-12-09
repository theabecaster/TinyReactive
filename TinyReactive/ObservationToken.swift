//
//  ObservationToken.swift
//  TinyReactive
//
//  Created by Abraham Gonzalez on 12/5/20.
//

import Foundation

public class ObservationToken {
    private let cancellationClosure: () -> Void
    
    init(cancellationClosure: @escaping () -> Void) {
        self.cancellationClosure = cancellationClosure
    }
    
    public func cancel() { cancellationClosure() }
}
