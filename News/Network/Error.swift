//
//  Error.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import Foundation

public protocol APIError: Codable {
    var message: String { get }
    var code: String? { get }
    var status: String? { get set }
    var httpStatus: Int? { get set }
}

public class ClientError: APIError {
    public var message: String
    public var code: String?
    public var status: String?
    public var httpStatus: Int?
}

public enum APIClientError: Error {
    case handledError(error: APIError)
    case networkError
    case decoding(error: DecodingError?)
    case timeout

    public var message: String {
        switch self {
        case .handledError(let error):
            return error.message
        case .decoding:
            return "Decoding Error"
        case .networkError:
            return "Connection Error"
        case .timeout:
            return "Timeout"
        }
    }

    public var debugMessage: String {
        switch self {
        case .handledError(let error):
            return error.message
        case .decoding(let decodingError):
            guard let decodingError = decodingError else { return "Decoding Error" }
            return "\(decodingError)"
        case .networkError:
            return "Network error"
        case .timeout:
            return "Timeout"
        }
    }
    
    public var status: String? {
        switch self {
        case .handledError(let error):
            return error.status
        case .decoding:
            return "Decoding Error"
        case .networkError:
            return "Connection Error"
        case .timeout:
            return "Timeout"
        }
    }
    
    public var httpStatus: Int {
        switch self {
        case .handledError(let error):
            return error.httpStatus ?? 0
        case .decoding:
            return NSURLErrorCannotDecodeRawData
        case .networkError:
            return 400
        case .timeout:
            return NSURLErrorTimedOut
        }
    }
}
