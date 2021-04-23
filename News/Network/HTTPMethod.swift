//
//  HTTPMethod.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import Foundation
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias HTTPHeaders = Alamofire.HTTPHeaders
public typealias HTTPHeader = Alamofire.HTTPHeader

public extension HTTPMethod {
    var encoding: ParameterEncoding {
        switch self {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
