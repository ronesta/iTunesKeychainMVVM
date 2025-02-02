//
//  SceneDelegate.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 25.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let searchNavigationController = SearchAssembly().build()
        let historyNavigationController = SearchHistoryAssembly().build()

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [searchNavigationController, historyNavigationController]

        tabBarController.tabBar.barTintColor = .white

        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}
