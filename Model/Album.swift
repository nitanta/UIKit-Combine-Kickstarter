//
//  User.swift
//  Book share
//
//  Created by Nitanta Adhikari on 4/27/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation

struct Album: Codable {
    let id, userID, title: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case links = "_links"
    }
}

struct Links: Codable {
    let linksSelf, edit: Edit

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case edit
    }
}

struct Edit: Codable {
    let href: String
}
