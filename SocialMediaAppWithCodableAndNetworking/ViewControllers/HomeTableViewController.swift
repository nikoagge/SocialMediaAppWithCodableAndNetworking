//
//  HomeTableViewController.swift
//  SocialMediaAppWithCodableAndNetworking
//
//  Created by Nikolas Aggelidis on 29/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    var friends = [Friend]()
    var filteredFriends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        networking()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find a friend"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func networking() {
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                let downloadedFriends = try jsonDecoder.decode([Friend].self, from: data)
                
                DispatchQueue.main.async {
                    self.friends = downloadedFriends
                    self.filteredFriends = downloadedFriends
                    self.tableView.reloadData()
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        defaultTableViewCell.textLabel?.text = filteredFriends[indexPath.row].name
        defaultTableViewCell.detailTextLabel?.text = filteredFriends[indexPath.row].friends.map { $0.name }.joined(separator: ",")
        
        return defaultTableViewCell
    }
}

extension HomeTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 0 {
            filteredFriends = friends.filter { $0.name.contains(text) || $0.company.contains(text) || $0.address.contains(text) }
        } else {
            filteredFriends = friends
        }
        
        tableView.reloadData()
    }
}
