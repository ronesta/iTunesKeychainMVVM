//
//  SearchCollectionViewDataSource.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation
import UIKit

final class SearchCollectionViewDataSource: NSObject, SearchDataSourceProtocol {
    var viewModel: SearchViewModelProtocol?
    var networkManager: NetworkManagerProtocol?

    init(viewModel: SearchViewModelProtocol?,
         networkManager: NetworkManagerProtocol?
    ) {
        self.viewModel = viewModel
        self.networkManager = networkManager
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getAlbumsCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumCollectionViewCell.id,
            for: indexPath)
                as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }

        guard let album = viewModel?.getAlbum(at: indexPath.item) else {
            return UICollectionViewCell()
        }

        let urlString = album.artworkUrl100

        networkManager?.loadImage(from: urlString) { loadedImage in
            DispatchQueue.main.async {
                guard let cell = collectionView.cellForItem(at: indexPath) as? AlbumCollectionViewCell else {
                    return
                }

                let viewModel = AlbumCellViewModel(album: album, image: loadedImage)
                cell.configure(with: viewModel)
            }
        }
        return cell
    }
}
