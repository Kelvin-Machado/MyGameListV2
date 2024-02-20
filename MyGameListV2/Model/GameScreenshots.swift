//
//  GameScreenshots.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 17/02/24.
//

import Foundation

struct GameScreenshots: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [ImageResult]
}

struct ImageResult: Codable {
    let id: Int
    let image: String
    let width: Int
    let height: Int
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case id, image, width, height
        case isDeleted = "is_deleted"
    }
}

