//
//  GetResponse.swift
//  RestCommand
//
//  Created by Dmitriy Soloshenko on 02.11.2022.
//

import Foundation

struct GetResponse: Codable {
    let args: [String: String]
    let headers: Headers
    let url: String
}
