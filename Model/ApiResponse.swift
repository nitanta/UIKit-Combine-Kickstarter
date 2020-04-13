//
//  ApiResponse.swift
//  Book share
//
//  Created by Nitanta Adhikari on 4/27/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation

struct ApiResponse: Codable {
    let meta: Meta
    let result: Data

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        self.meta   = try container.decode(Meta.self, forKey: .meta)
        let dataDict: [String: Any] = try container.decode([String: Any].self, forKey: .result)
        self.result  = dataDict.dataRepresentation ?? Data()
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

