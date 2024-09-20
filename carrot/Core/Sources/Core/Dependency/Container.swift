//
//  Container.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Foundation

class Container {
    private var services: [String: Any] = [:]
    
    static let shared = Container()
    
    private init() {}
    
    // 객체를 등록하는 함수
    func register<ServiceType>(type: ServiceType.Type, factory: @escaping () -> ServiceType) {
        let key = String(describing: type)
        services[key] = factory
    }
    
    // 객체를 가져오는 함수
    func resolve<ServiceType>(type: ServiceType.Type) -> ServiceType? {
        let key = String(describing: type)
        if let factory = services[key] as? () -> ServiceType {
            return factory()
        }
        return nil
    }
}
