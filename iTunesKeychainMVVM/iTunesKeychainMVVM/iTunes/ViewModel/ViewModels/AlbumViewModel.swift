//
//  AlbumViewModel.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation
import UIKit

final class AlbumViewModel: AlbumViewModelProtocol {
    var networkManager: NetworkManagerProtocol?

    let albumImage: Observable<UIImage?> = Observable(nil)
    let albumName: Observable<String?> = Observable(nil)
    let artistName: Observable<String?> = Observable(nil)
    let collectionPrice: Observable<String?> = Observable(nil)

    private var album: Album

    init(networkManager: NetworkManagerProtocol,
         album: Album
    ) {
        self.networkManager = networkManager
        self.album = album
        setupBindings()
    }

    private func setupBindings() {
        albumName.value = album.collectionName
        artistName.value = album.artistName
        collectionPrice.value = "\(album.collectionPrice) $"

        let urlString = album.artworkUrl100
        networkManager?.loadImage(from: urlString) { [weak self] loadedImage in
            DispatchQueue.main.async {
                self?.albumImage.value = loadedImage
            }
        }
    }

    func fetchAlbumImage(completion: @escaping (UIImage?) -> Void) {
        networkManager?.loadImage(from: album.artworkUrl100, completion: completion)
    }
}
