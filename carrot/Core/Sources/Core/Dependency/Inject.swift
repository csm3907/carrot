//
//  Inject.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Foundation

@propertyWrapper
public struct Inject<Value> {
    public private(set) var wrappedValue: Value
    private let container = Container.shared

    public init() {
        guard let value = container.resolve(type: Value.self) else {
            fatalError("Could not resolve non-optional \(Value.self)")
        }
        wrappedValue = value
    }

    public init<Wrapped>(name: String? = nil) where Value == Optional<Wrapped> {
        wrappedValue = container.resolve(type: Wrapped.self)
    }
}
