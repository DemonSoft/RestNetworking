//
//  Headers.swift
//  RestCommand
//
//  Created by Dmitriy Soloshenko on 02.11.2022.
//

import Foundation

struct Headers: Codable {
    let host: String
    let accept: String
    let aEncoding: String
    
    enum CodingKeys: String, CodingKey {
        case host
        case accept
        case acceptEncoding = "accept-encoding"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(host, forKey: .host)
        try container.encode(accept, forKey: .accept)
        try container.encode(aEncoding, forKey: .acceptEncoding)
      }
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
          host = try container.decode(String.self, forKey: .host)
          accept = try container.decode(String.self, forKey: .accept)
          aEncoding = try container.decode(String.self, forKey: .acceptEncoding)
      }
}
