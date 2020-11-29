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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking()
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
                    self.tableView.reloadData()
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        defaultTableViewCell.textLabel?.text = friends[indexPath.row].name
        defaultTableViewCell.detailTextLabel?.text = friends[indexPath.row].friends.map { $0.name }.joined(separator: ",")
        
        return defaultTableViewCell
    }
}
