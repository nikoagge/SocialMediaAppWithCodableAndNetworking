//
//  HomeTableViewController.swift
//  SocialMediaAppWithCodableAndNetworking
//
//  Created by Nikolas Aggelidis on 29/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    let friendsDataSource = FriendsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupDataSource()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find a friend"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func setupDataSource() {
        friendsDataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        friendsDataSource.fetch("https://www.hackingwithswift.com/samples/friendface.json")
        tableView.dataSource = friendsDataSource
    }
}

extension HomeTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        friendsDataSource.filterText = searchController.searchBar.text
    }
}
