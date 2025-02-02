//
//  SearchDataSourceProtocol.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation
import UIKit

protocol SearchDataSourceProtocol: AnyObject, UICollectionViewDataSource {
    var viewModel: SearchViewModelProtocol? { get set }
    var networkManager: NetworkManagerProtocol? { get set }
}
