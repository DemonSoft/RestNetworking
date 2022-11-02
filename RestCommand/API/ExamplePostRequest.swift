//
//  ExamplePostRequest.swift
//  RestCommand
//
//  Created by Dmitriy Soloshenko on 02.11.2022.
//

import Foundation

class ExamplePostRequest : NetworkBase {
    
    // MARK: - Types
    struct Params: Encodable {
        let arg: String
        let name: String
        let age: Int
    }
    // MARK: - Variables
    override var command: String { return "post" }
    private (set) var result:PostResponse?
    
    func request(arg: String, name: String, age: Int) {
        let params = Params(arg: arg, name: name, age: age)
        self.request(type:.POST, params: params)
    }
    
    override func receiveData(data:Data) {
        if let response:PostResponse = self.parse(data: data) {
            self.result = response
            print(response)
        }
    }
}
