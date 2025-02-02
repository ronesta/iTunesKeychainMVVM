//
//  AlbumCellViewModel.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation
import UIKit

struct AlbumCellViewModel: AlbumCellViewModelProtocol {
    let collectionName: String
    let artistName: String
    let albumImage: UIImage?

    init(album: Album, image: UIImage?) {
        self.collectionName = album.collectionName
        self.artistName = album.artistName
        self.albumImage = image
    }
}
