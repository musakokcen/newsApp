//
//  NetworkManager.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import Foundation
import Alamofire

public typealias Completion<T> = (Result<T, APIClientError>) -> Void where T: Decodable

public class EmptyResponse: Codable {
    public init() {}
}

final public class NetworkManager {
    
    static let sharedInstance: NetworkManager = NetworkManager(sessionManager: Alamofire.Session(configuration: URLSessionConfiguration.default))
    
    private let sessionManager: Alamofire.Session
    
    public init(sessionManager: Alamofire.Session = Alamofire.Session(configuration: URLSessionConfiguration.default)) {
        self.sessionManager = sessionManager
    }
    
    private var possibleEmptyBodyResponseCodes: Set<Int> {
        var defaultSet = DataResponseSerializer.defaultEmptyResponseCodes
        defaultSet.insert(200)
        defaultSet.insert(201)
        return defaultSet
    }
    
    public func cancelRequests(completion: @escaping (Bool) -> Void) {
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, _, _ in
            if dataTasks.count > 0 {
                dataTasks.forEach { $0.cancel()
                    completion(true)
                }
            } else {
                completion(true)
            }
        }
    }
    
    public func request<T: Decodable>(endpoint: Endpoint, type: T.Type, completion: @escaping Completion<T>) {
        sessionManager.request(endpoint.url,
                               method: endpoint.method,
                               parameters: endpoint.params,
                               encoding: endpoint.method.encoding,
                               headers: endpoint.headers)
            .validate()
            .response(responseSerializer: DataResponseSerializer(emptyResponseCodes: possibleEmptyBodyResponseCodes), completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    guard !data.isEmpty else {
                        completion(.success(EmptyResponse() as! T))
                        return
                    }
                    
                    do {
                        let decodedObject = try JSONDecoder().decode(type, from: data)
                        completion(.success(decodedObject))
                    } catch {
                        let decodingError = APIClientError.decoding(error: error as? DecodingError)
                        completion(.failure(decodingError))
                    }
                    
                case .failure(let error):
                    if (error as NSError).code == NSURLErrorTimedOut {
                        completion(.failure(.timeout))
                    } else {
                        do {
                            guard let data = response.data else {
                                completion(.failure(.networkError))
                                return
                            }
                            let clientError = try JSONDecoder().decode(ClientError.self, from: data)
                            clientError.httpStatus = error.responseCode
                            completion(.failure(.handledError(error: clientError)))
                        } catch {
                            let decodingError = APIClientError.decoding(error: error as? DecodingError)
                            completion(.failure(decodingError))
                        }
                    }
                }
            })
    }
}
