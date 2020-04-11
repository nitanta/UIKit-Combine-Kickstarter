//
//  ApiResponse.swift
//  Book share
//
//  Created by Nitanta Adhikari on 4/27/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation

struct ApiResponse : Codable {
    var message: String?
    var status: String?
    var responseCode: String?
    var statusCode: Int?
    var data: Data?
    
    enum CodingKeys: String, CodingKey {
        case message
        case status
        case responseCode
        case statusCode
        case data
    }
    
    //manual setup initializer
    public init(message: String?, status: String?, responseCode: String?, statusCode: Int?, data: Data?) {
        self.message            = message
        self.status             = status
        self.responseCode       = responseCode
        self.statusCode         = statusCode
        self.data               = data
    }
    
    //making compiler happy
    public func encode(to encoder: Encoder) throws { }
    
    //Decoding initializer
    public init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.message        = try container.decodeIfPresent(String.self, forKey: .message)
        self.status         = try container.decodeIfPresent(String.self, forKey: .status)
        self.responseCode   = try container.decodeIfPresent(String.self, forKey: .responseCode)
        self.statusCode     = try container.decodeIfPresent(Int.self, forKey: .statusCode)
        self.data           = try container.decodeIfPresent(Data.self, forKey: .data)
    }
}
