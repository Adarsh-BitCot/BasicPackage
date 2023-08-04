//
//  NetworkManager.swift
//
//  Created by Adarsh Sharma on 28/07/23.
//

import Foundation
import Alamofire

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private override init() {}
    func makeAPICall(urlString: String,
                     parameters: [String: Any] = [:],
                     headers : HTTPHeaders = [:],
                     method: String = "GET",
                     encoding: ParameterEncoding = URLEncoding.default,
                     completion:@escaping (Result<Data, Errors>) -> Void) {
        
        if Reachability.isConnectedToNetwork() {
            AF.request(urlString,
                       method: HTTPMethod(rawValue: method),
                       parameters: parameters,
                       encoding: encoding,
                       headers: headers).response { responseData in
                if let jsonData = responseData.data {
                    completion(.success(jsonData))
                }else{
                    completion(.failure(.invalidData))
                }
            }
        }else{
            completion(.failure(.apiError(message: "NO INTERNET")))
        }
    }
}
