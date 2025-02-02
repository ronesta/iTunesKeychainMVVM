//
//  SearchViewModel.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation

final class SearchViewModel: SearchViewModelProtocol {
    var albums: Observable<[Album]> = Observable([])

    var networkManager: NetworkManagerProtocol
    var storageManager: StorageManagerProtocol

    init(networkManager: NetworkManagerProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.networkManager = networkManager
        self.storageManager = storageManager
    }

    var searchHistory: [String] {
        return storageManager.getSearchHistory()
    }

    func searchAlbums(with term: String) {
        let savedAlbums = storageManager.loadAlbums(for: term)

        if !savedAlbums.isEmpty {
            albums.value = savedAlbums
            return
        }

        networkManager.loadAlbums(albumName: term) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let albums):
                DispatchQueue.main.async {
                    self.albums.value = albums.sorted { $0.collectionName < $1.collectionName }
                    for album in albums {
                        self.storageManager.saveAlbum(album, for: term)
                    }
                    print("Successfully loaded \(albums.count) albums.")
                }
            case .failure(let error):
                print("Failed to load images with error: \(error.localizedDescription)")
            }
        }
    }

    func getAlbumsCount() -> Int {
        return albums.value.count
    }

    func getAlbum(at index: Int) -> Album {
        return albums.value[index]
    }
}
