//
//  SearchAssembly.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation
import UIKit

struct SearchAssembly {
    func build() -> UIViewController {
        let storageManager = KeychainSevice()
        let networkManager = NetworkManager(storageManager: storageManager)

        let searchViewModel = SearchViewModel(
            networkManager: networkManager,
            storageManager: storageManager
        )
        let searchCollectionViewDataSource = SearchCollectionViewDataSource(
            viewModel: searchViewModel,
            networkManager: networkManager
        )

        let searchViewController = SearchViewController()
        searchViewController.viewModel = searchViewModel
        searchViewController.storageManager = storageManager
        searchViewController.collectionViewDataSource = searchCollectionViewDataSource

        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        let searchTabBarItem = UITabBarItem(title: "Search",
                                            image: UIImage(systemName: "magnifyingglass"),
                                            tag: 0)
        searchTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        searchNavigationController.tabBarItem = searchTabBarItem

        return searchNavigationController
    }
}
