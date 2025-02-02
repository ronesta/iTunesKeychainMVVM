//
//  SearchHistoryAssembly.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation
import UIKit

struct SearchHistoryAssembly {
    func build() -> UIViewController {
        let storageManager = KeychainSevice()

        let searchHistoryModel = SearchHistoryViewModel(storageManager: storageManager)

        let searchHistoryTableViewDataSource = SearchHistoryTableViewDataSource(viewModel: searchHistoryModel)

        let searchHistoryViewController = SearchHistoryViewController()
        searchHistoryViewController.viewModel = searchHistoryModel
        searchHistoryViewController.tableViewDataSource = searchHistoryTableViewDataSource

        let historyNavigationController = UINavigationController(rootViewController: searchHistoryViewController)
        let historyTabBarItem = UITabBarItem(title: "History",
                                             image: UIImage(systemName: "clock"),
                                             tag: 1)
        historyTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        historyNavigationController.tabBarItem = historyTabBarItem

        return historyNavigationController
    }
}
