//
//  GuideResponse.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import Foundation

struct GuideResponse: Codable {
    let data: [Guide]?
    let total: String?
}
