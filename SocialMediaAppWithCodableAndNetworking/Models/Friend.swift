//
//  Friend.swift
//  SocialMediaAppWithCodableAndNetworking
//
//  Created by Nikolas Aggelidis on 29/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import Foundation

struct Friend: Codable {
    let uuid: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Connection]
    
    var friendsList: String {
        return friends.map { $0.name }.joined(separator: ", ")
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid = "id"
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }
}

extension Array where Element == Friend {
    func matching(_ text: String?) -> [Friend] {
        if let text = text, text.count > 0 {
            return self.filter { $0.name.contains(text) || $0.company.contains(text) || $0.address.contains(text) }
        } else {
            return self
        }
    }
}
