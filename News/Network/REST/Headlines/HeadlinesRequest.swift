//
//  HeadlinesRequest.swift
//  News
//
//  Created by Musa Kokcen on 14.03.2021.
//

import Foundation

struct HeadlinesRequest: Encodable {
    let category: String
    let pageSize: Int
    let page: Int
    var q: String?
}
