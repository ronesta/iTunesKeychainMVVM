//
//  NetworkManager.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 25.01.2025.
//

import Foundation
import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    var dataCounter = 1
    var imageCounter = 1

    private init() {}

    func fetchAlbums(albumName: String, completion: @escaping (Result<[Album], Error>) -> Void) {
        let baseURL = "https://itunes.apple.com/search"
        let term = albumName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?term=\(term)&entity=album&attribute=albumTerm"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data else {
                print("No data")
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }

            do {
                let albums = try JSONDecoder().decode(PostAlbums.self, from: data).results
                DispatchQueue.main.async {
                    completion(.success(albums))
                    print("Load data \(self.dataCounter)")
                    self.dataCounter += 1
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {

        if let imageData = KeychainSevice.shared.loadImage(key: urlString),
           let image = UIImage(data: imageData) {
            completion(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            if let data,
               let image = UIImage(data: data) {
                KeychainSevice.shared.saveImage(data, key: urlString)
                DispatchQueue.main.async {
                    completion(image)
                    print("Load image \(self.imageCounter)")
                    self.imageCounter += 1
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
