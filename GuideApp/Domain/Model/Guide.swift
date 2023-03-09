//
//  Guide.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import Foundation

struct Guide: Codable {
    let url : String?
    let startDate : String
    let endDate : String?
    let name: String?
    let icon: String?
    let objType: String?
    let loginRequired: Bool?
}
