//
//  HTTPRequest.swift
//  
//
//  Created by bitcot on 28/07/23.
//

import Foundation

public struct HTTPRequest {
    public let url: URL
    public let params: [String: Any]
    public let body: Any?
    public let httpMethod: HTTPMethod
    public let customHeaders: [String: String]?

    public enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
        case patch = "PATCH"
        case head = "HEAD"
    }

    public init(url: URL,
                httpMethod: HTTPMethod,
                params: [String: Any],
                body: Any? = .none,
                customHeaders: [String: String]? = ["Content-Type": "application/json"] ) {
        self.url = url
        self.httpMethod = httpMethod
        self.params = params
        self.body = body
        self.customHeaders = customHeaders
    }

    public init?(urlRequest: URLRequest) {
        guard let url = urlRequest.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            let baseUrl = url.baseURL,
            let httpMethod = urlRequest.httpMethod else { return nil }

        self.url = baseUrl
        var params: [String: Any] = [:]
        urlComponents.queryItems?.forEach { params[$0.name] = $0.value }
        self.params = params

        if let httpBody = urlRequest.httpBody {
            do {
                let httpBodyJson = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments) as? [String: Any]
                self.body = httpBodyJson
            } catch {
                self.body = .none
            }
        } else {
            self.body = .none
        }

        self.httpMethod = HTTPMethod(rawValue: httpMethod) ??  .get
        self.customHeaders = urlRequest.allHTTPHeaderFields
    }
}

extension HTTPRequest {
    public var urlRequest: URLRequest? {
        var componant = URLComponents(url: url, resolvingAgainstBaseURL: false)
        componant?.queryItems = params.compactMap { return URLQueryItem(name: $0.key, value: "\($0.value)") }
        guard let componantUrl = componant?.url else { return nil }
        var request = URLRequest(url: componantUrl)
        request.httpMethod = httpMethod.rawValue
        if let body = body {
            do { request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) } catch {}
        }

        customHeaders?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        return request
    }
}
