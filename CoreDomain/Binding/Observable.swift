//
//  Observable.swift
//  CoreDomain
//
//  Created by Kirill on 09.01.2024.
//

import Foundation

// MARK: - Observable
final public class Observable<T> {
    
    public typealias SomeType = T
    
    public var value: SomeType {
        didSet {
            self.react()
        }
    }
    private var reactiveAction: ((SomeType) -> Void)?
    
    public init(value: SomeType) {
        self.value = value
    }
    
    public func bind(reactiveAction: @escaping (SomeType) -> Void) -> Void {
        self.reactiveAction = reactiveAction
    }
    
    private func react() -> Void {
        self.reactiveAction?(value)
    }
    
}
