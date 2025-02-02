//
//  NetworkManagerProtocol.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import UIKit

protocol NetworkManagerProtocol: AnyObject {
    func loadAlbums(albumName: String, completion: @escaping (Result<[Album], Error>) -> Void)

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}
