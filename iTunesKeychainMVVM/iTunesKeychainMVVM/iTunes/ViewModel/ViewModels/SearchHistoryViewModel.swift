//
//  SearchHistoryViewModel.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation

final class SearchHistoryViewModel: SearchHistoryViewModelProtocol {
    var storageManager: StorageManagerProtocol?

    var searchHistory: Observable<[String]> = Observable([])

    init(storageManager: StorageManagerProtocol?) {
        self.storageManager = storageManager
        updateSearchHistory()
    }

    func updateSearchHistory() {
        let history = storageManager?.getSearchHistory()
        searchHistory.value = history ?? []
    }

    func getSearchHistoryCount() -> Int {
        return searchHistory.value.count
    }

    func getSearchHistory(at index: Int) -> String {
        return searchHistory.value[index]
    }
}
