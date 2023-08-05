//
//  Encodable+Extension.swift
//  PackageExample
//
//  Created by Adarsh Sharma on 04/08/23.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self)
        else { return [:] }
        
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else { return [:] }
        
        return json
    }
}
