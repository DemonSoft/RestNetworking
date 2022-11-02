//
//  NetworkSetup.swift
//  RestCommand
//
//  Created by Dmitriy Soloshenko on 01.11.2022.
//

import Foundation

class NetworkSetup {
    private let bearer   = "<Bearer>"
    private let host     = "postman-echo.com"
    private let scheme   = "https"
    let timeout : Double = 30
}

extension NetworkSetup {
    
    func urlRequest(cmd: String, type:HttpType = .GET, params:Data? = nil) -> URLRequest? {
        guard let url               = self.urlBulder(cmd) else { return nil}
        var request                 = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.allHTTPHeaderFields = self.headers
        request.timeoutInterval     = self.timeout
        request.httpMethod          = type.rawValue
        request.httpBody            = params
        request.cachePolicy         = .reloadIgnoringLocalCacheData
        return request
    }
    
    // MARK: - Private
    private var headers: [String: String] {
        return ["Authorization": "Bearer \(self.bearer)",
                "Accept": "application/json",
                "Content-Type": "application/json"]
    }

    private func urlBulder(_ cmd: String) -> URL? {
        
        let link = "\(self.scheme)://\(self.host)/\(cmd)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        return URL(string: link)
    }
}
