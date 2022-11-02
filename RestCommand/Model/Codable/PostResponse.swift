//
//  PostResponse.swift
//  RestCommand
//
//  Created by Dmitriy Soloshenko on 02.11.2022.
//

import Foundation

struct PostResponse: Codable {
    let args: [String: String]
    let headers: Headers
    let url: String
    let data: DataResponse
}

struct DataResponse: Codable {
    let arg: String
    let name: String
    let age: Int
}
