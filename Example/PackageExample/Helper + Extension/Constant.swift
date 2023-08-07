//
//  Constant.swift
//  PackageExample
//
//  Created by Adarsh Sharma on 02/08/23.
//

import Foundation

var reqresBaseURL: String {
    return "https://reqres.in/api"
}

struct ApiURL {
    static let reqresLogin = "\(reqresBaseURL)/login"
}

struct HttpMethod {
    static let get = "GET"
    static let put = "PUT"
    static let post = "POST"
    static let patch = "PATCH"
    static let delete = "DELETE"
}
