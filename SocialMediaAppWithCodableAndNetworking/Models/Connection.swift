//
//  Connection.swift
//  SocialMediaAppWithCodableAndNetworking
//
//  Created by Nikolas Aggelidis on 29/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import Foundation

struct Connection: Codable {
    var uuid: UUID
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case uuid = "id"
        case name
    }
}
