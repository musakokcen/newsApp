//
//  EncodableExtensions.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import Foundation

public extension Encodable {
    func parameters() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return nil
        }
        return dictionary
    }

    func toJsonString() -> String? {
        let encoder = JSONEncoder()
        if #available(iOS 11.0, *) {
            encoder.outputFormatting = .sortedKeys
        }
        guard let data = try? encoder.encode(self),
        let jsonString  = String(data: data, encoding: .utf8) else { return nil }
        return jsonString
    }
}
