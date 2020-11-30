//
//  FriendsDataSource.swift
//  SocialMediaAppWithCodableAndNetworking
//
//  Created by Nikolas Aggelidis on 29/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

class FriendsDataSource: NSObject, UITableViewDataSource {
    var friends = [Friend]()
    var filteredFriends = [Friend]()
    var dataChanged: (() -> Void)?
    
    var filterText: String? {
        didSet {
            filteredFriends = friends.matching(filterText)
            self.dataChanged?()
        }
    }
    
    func fetch(_ urlString: String) {
            let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
            JSONDecoder().dateDecodingStrategy = .iso8601
            JSONDecoder().decode([Friend].self, from: urlString) { (friends) in
            self.friends = friends
            self.filteredFriends = friends
            self.dataChanged?()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        defaultTableViewCell.textLabel?.text = filteredFriends[indexPath.row].name
        defaultTableViewCell.detailTextLabel?.text = filteredFriends[indexPath.row].friendsList
        
        return defaultTableViewCell
    }
}
