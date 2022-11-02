//
//  NetworkBase.swift
//  RestCommand
//
//  Created by Dmitriy Soloshenko on 01.11.2022.
//

import Foundation

typealias NetworkCallback = (_ request: NetworkBase) -> Void

enum HttpType : String {
    case GET
    case POST
    case UPDATE
    case PUT
    case PATCH
    case SEARCH
    case DELETE
}

class NetworkBase {
    var command : String { return "" }
    private (set) var successed = false
    private var callbackHandler:  NetworkCallback?
    private var startedRequest  = Date()
    private var commandLink     = ""

    func callback(_ callbackHandler: NetworkCallback? = nil) -> Self {
        self.callbackHandler = callbackHandler
        return self
    }
    
    func request(type:HttpType = .GET, params:Encodable? = nil) {
        
        Task {
            var encodedData: Data? = nil
            if let params = params, let data = try? JSONEncoder().encode(params) {
                encodedData = data
            }

            guard let request = NetworkSetup()
                .urlRequest(cmd: self.command, type: type, params: encodedData) else {
                print("Request is not valide")
                return }
            
            self.commandLink    = "\(request.url!.relativePath)"
            self.startedRequest = Date()
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                self.handle(data)
            } catch(let error) {
                self.handle(error)
            }
        }
    }
    
    func commit() {
        self.callbackHandler?(self)
    }
    
    /// This method overrides in children classes.
    func receiveData(data: Data) {
        print(String(data: data, encoding: .utf8)!)
    }
    
    /// Parsing received data.
    func parse<T:Decodable>(data: Data) -> T?
    {
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch (let error) {
            if let error = error as? Swift.DecodingError {
                print("‼️ DECODE ERROR")
                print("‼️ \(error)")
            }
            print("‼️ \(error.localizedDescription)\n")
        }
        return nil
    }

    // MARK: - Private section
    
    private func handle(_ data: Data) {
        self.successed = true
        self.receiveData(data: data)
        self.showTimeRequest()
        self.commit()
    }
    
    private func handle(_ error: Error?) {
        if let error = error as? URLError, error.code == .timedOut {
            print("‼️ TIME OUT\n")
        } else if let error = error as NSError?, error.code == -1009 || error.code == -1020 {
            print("‼️ NO INTERNET CONNECTION")
        }

        if let error = error {
            print("‼️ \(error.localizedDescription)\n")
        }

        self.callbackHandler?(self)
    }

    private func showTimeRequest() {
        let delta = -self.startedRequest.timeIntervalSinceNow
        print("Duration \(delta) of /\(self.commandLink)\n")
    }


}
