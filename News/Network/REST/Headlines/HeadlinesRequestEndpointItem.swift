//
//  HeadlinesRequestEndpointItem.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import Foundation
enum HeadlinesRequestEndpointItem: Endpoint {
    
    case headlines(request: HeadlinesRequest)

    var path: String {
        switch self {
        case .headlines:
            return "top-headlines"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .headlines:
            return .get
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .headlines(let params):
            return params.parameters()
        }
    }
}
