//
//  HTTPClient.swift
//  
//
//  Created by bitcot on 28/07/23.

import Foundation


protocol Service {
    var client: HTTPClient { get }
}

protocol HTTPClient {
    func request(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func request(_ request: HTTPRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func request<V>(_ request: HTTPRequest, type: V.Type, completion: @escaping (Result<V, NetworkError>) -> Void) where V: Decodable
    func json(httpRequest: HTTPRequest, completion: @escaping (Result<[String: Any], NetworkError>) -> Void)
}

extension HTTPClient {
    public func json(httpRequest: HTTPRequest, completion: @escaping (Result<[String: Any], NetworkError>) -> Void) {
        request(httpRequest) { (dataRequest: Result<Data, NetworkError>) in
            switch dataRequest {
            case .success(let data):
                do {
                    if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                        completion(.success(jsonDictionary))
                        return
                    }

                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(.success(["json": json]))
                } catch let error {
                    completion(.failure(.network(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
    
    public func request<V>(_ request: HTTPRequest, type: V.Type, completion: @escaping (Result<V, NetworkError>) -> Void) where V : Decodable {
        
        if Reachability.isConnectedToNetwork(){
            self.request(request) { (dataRequest: Result<Data, NetworkError>) in
                switch dataRequest {
                case .success(let data):
                    
                    do {
                        print(data.prettyString ?? "")
                        let object = try JSONDecoder().decode(type, from: data)
                        completion(.success(object))
                    } catch let error {
                        completion(.failure(.network(error)))
                    }
                case .failure(let error):
                    completion(.failure(.network(error)))
                }
            }
        }else{
            completion(.failure(.apiError(message: "Internet Connection not Available!")))
        }
    }
}

extension Data {
    var prettyString: NSString? {
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue) ?? nil
    }
}
