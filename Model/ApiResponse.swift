//
//  ApiResponse.swift
//  Book share
//
//  Created by Nitanta Adhikari on 4/27/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let meta: Meta
    let result: T?

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        self.meta   = try container.decode(Meta.self, forKey: .meta)
        self.result  = try container.decodeIfPresent(T.self, forKey: .result)
    }
}

struct Meta: Codable {
    let success: Bool
    let code: Int
    let message: String
    let totalCount, pageCount, currentPage, perPage: Int?
    let rateLimit: RateLimit?
}

struct RateLimit: Codable {
    let limit, remaining, reset: Int
}

