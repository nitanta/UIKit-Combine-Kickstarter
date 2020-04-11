//
//  User.swift
//  Book share
//
//  Created by Nitanta Adhikari on 4/27/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation

struct User: Codable {
    let email: String?
    let fullName: String?
    let id: Int?
    let mobileNo: String?
    let activated: Bool?
    let imagePath: String?
    let userName: String?
    let points: Int?
    let followedById: Int?
    let followedToId: Int?
}
