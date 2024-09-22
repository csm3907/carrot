//
//  AppDelegate.swift
//  carrot
//
//  Created by 최승민 on 9/20/24.
//

import UIKit

import Feature
import Core
import Data
import Domain

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureContainer()
        
        window = UIWindow()
        let nav = UINavigationController(rootViewController: SearchViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    @discardableResult
    func configureContainer() -> Container {
        let container = Container.shared
        registerServices(container: container)
        return container
    }
    
    func registerServices(container: Container) {
        let network = NetworkImp(session: URLSession.shared)
        
        let searchRepository = SearchRepositoryImp(baseURL: Constant.baseURL, network: network)
        container.register(type: SearchRepository.self) {
            searchRepository
        }
        let detailRepository = BookDetailRepositoryImp(baseURL: Constant.baseURL, network: network)
        container.register(type: BookDetailRepository.self) {
            detailRepository
        }
    }
}
