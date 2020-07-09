//
// ProductList.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct ProductList: Codable {

    public var lastPage: Int = 0
    public var results: [Product] = []

    public init(lastPage: Int, results: [Product]) {
        self.lastPage = lastPage
        self.results = results
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case lastPage = "last_page"
        case results
    }

}