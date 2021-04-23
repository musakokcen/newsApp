//
//  Endpoint.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import Foundation

public protocol Endpoint: CustomStringConvertible {
    var baseUrl: NewsApiBaseUrl { get }
    var path: String { get }
    var params: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
    var url: String { get }
    var method: HTTPMethod { get }
}

public extension Endpoint {
    var baseUrl: NewsApiBaseUrl {
        return .newsApi
    }

    var params: [String: Any]? {
        return nil
    }

    var url: String {
        switch baseUrl {
        case .newsApi:
            let newsApiBaseUrl = "https://newsapi.org/v2/"
            return "\(newsApiBaseUrl)\(path)"
        }
    }

    var headers: HTTPHeaders? {
        switch baseUrl {
        case .newsApi:
            let headers = baseHeaders
            return headers
        }
    }
    
    var baseHeaders: HTTPHeaders? {
        var headers = [String: String]()
        headers["X-Api-Key"] = Constants.newsApiKey

        return HTTPHeaders(headers)
    }
    
    var description: String {
        var descriptionString = String()
        descriptionString.append(contentsOf: "\nURL: [\(method.rawValue)] \(url)")
        descriptionString.append(contentsOf: "\nHEADERS: \(headers ?? HTTPHeaders())")
        descriptionString.append(contentsOf: "\nPARAMETERS: \(String(describing: params ?? [:]))")
        return descriptionString
    }
}

public enum NewsApiBaseUrl {
    case newsApi
}
