//
//  ContentViewModel.swift
//  RestCommand
//
//  Created by Dmitriy Soloshenko on 02.11.2022.
//

import Combine
import SwiftUI

class ContentViewModel : ObservableObject {
    
    @Published var result = "<UNKNOWN>"
    
    static var placeholder: ContentViewModel {
        return ContentViewModel()
    }
    
    func shortGetRequest() {
        let param = "SHORT get request completed"
        ExampleGetRequest().request(arg: param)
        self.result = ""
    }

    func getRequest() {
        let param = "GET request with callback completed"
        ExampleGetRequest().callback() {[weak self] request in
            guard let request = request as? ExampleGetRequest else { return }
            guard let self else { return }
            main {
                self.result = request.result?.args["test"] ?? ""
            }
        }.request(arg: param)
    }
    
    func postRequest() {
        let desc = "POST request with callback completed"
        ExamplePostRequest().callback() {[weak self] request in
            guard let request = request as? ExamplePostRequest else { return }
            guard let self else { return }
            guard let name = request.result?.data.name,
                  let age  = request.result?.data.age,
                  let desc = request.result?.data.arg else { return }
            main {
                self.result = "\(name), \(age)\n\(desc)"
            }
        }.request(arg: desc, name: "John", age: 44)
    }
}

func main(_ seconds:Double = 0.0, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        closure()
    }
}
