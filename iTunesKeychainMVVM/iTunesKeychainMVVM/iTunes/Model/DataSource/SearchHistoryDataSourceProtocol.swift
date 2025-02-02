//
//  SearchHistoryDataSourceProtocol.swift
//  iTunesKeychainMVVM
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation
import UIKit

protocol SearchHistoryDataSourceProtocol: AnyObject, UITableViewDataSource {
    var viewModel: SearchHistoryViewModelProtocol? { get set }
}
