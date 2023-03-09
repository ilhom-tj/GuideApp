//
//  NetworkConstants.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import Foundation

struct NetworkConstants {
    struct ProductionServer {
        static let baseURL = "https://guidebook.com/service/v2"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
