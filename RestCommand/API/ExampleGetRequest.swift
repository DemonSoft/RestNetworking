//
//  ExampleGetRequest.swift
//  RestCommand
//
//  Created by Dmitriy Soloshenko on 02.11.2022.
//

import Foundation

class ExampleGetRequest : NetworkBase {
    
    // MARK: - Types

    // MARK: - Variables
    override var command: String { return "get?test=\(self.arg)" }
    private (set) var arg = ""
    private (set) var result:GetResponse?
    
    func request(arg: String) {
        self.arg = arg
        self.request(type:.GET)
    }
    
    override func receiveData(data:Data) {
        if let response:GetResponse = self.parse(data: data) {
            self.result = response
            print(response)
        }
    }
}
