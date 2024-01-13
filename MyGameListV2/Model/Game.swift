//
//  Game.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 06/01/24.
//

import Foundation

// MARK: - Search

struct Search: Codable {
    let redirect: Bool
    let slug: String
}

// MARK: - Game
struct Game: Codable {
    let id: Int
    let slug: String
    let name: String
    let description: String?
    let metacritic: Int?
    let backgroundImage: String?
    let backgroundImageAdditional: String?
    let parentPlatforms: [ParentPlatform]?
    let platforms: [PlatformElement]?
    let stores: [Store]?
    let redirect: Bool?
    let rating: Double?
    let released: String?
    let tba: Bool? //jogo com data não anunciada

    private enum CodingKeys: String, CodingKey {
        case id, slug, name, metacritic, rating, tba
        case platforms, stores, redirect, released
        case description = "description_raw"
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case parentPlatforms = "parent_platforms"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(Int.self, forKey: .id)) ?? 0
        slug = (try? container.decode(String.self, forKey: .slug)) ?? ""
        name = (try? container.decode(String.self, forKey: .name)) ?? ""
        description = (try? container.decode(String.self, forKey: .description)) ?? ""
        metacritic = (try? container.decode(Int.self, forKey: .metacritic)) ?? 0
        backgroundImage = (try? container.decode(String.self, forKey: .backgroundImage)) ?? ""
        backgroundImageAdditional = (try? container.decode(String.self, forKey: .backgroundImageAdditional)) ?? ""
        parentPlatforms = (try? container.decode([ParentPlatform].self, forKey: .parentPlatforms)) ?? []
        platforms = (try? container.decode([PlatformElement].self, forKey: .platforms)) ?? []
        stores = (try? container.decode([Store].self, forKey: .stores)) ?? []
        redirect = (try? container.decode(Bool.self, forKey: .redirect)) ?? false
        rating = (try? container.decode(Double.self, forKey: .rating)) ?? 0.0
        released = (try? container.decode(String.self, forKey: .released)) ?? ""
        tba = (try? container.decode(Bool.self, forKey: .tba)) ?? false
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int
    let dropped, playing: Int
}

// MARK: - Clip
struct Clip: Codable {
    let clip: String
    let clips: Clips
    let video: String
    let preview: String
}

// MARK: - Clips
struct Clips: Codable {
    let the320, the640, full: String

    enum CodingKeys: String, CodingKey {
        case the320 = "320"
        case the640 = "640"
        case full
    }
}

// MARK: - Developer
struct Developer: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?
    let language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

enum Language: String, Codable {
    case eng = "eng"
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int
    let name, slug: String
}

// MARK: - MetacriticPlatform
struct MetacriticPlatform: Codable {
    let metascore: Int
    let url: String
    let platform: MetacriticPlatformPlatform
}

// MARK: - MetacriticPlatformPlatform
struct MetacriticPlatformPlatform: Codable {
    let platform: Int
    let name, slug: String
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    let platform: EsrbRating
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformPlatform
    let releasedAt: String?
    let requirements: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirements
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int
    let name, slug: String
    let image, yearEnd: JSONNull?
    let yearStart: Int?
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
// MARK: - Requirements

struct Requirements: Codable {
    let minimum, recommended: String?
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

// MARK: - Store
struct Store: Codable {
    let id: Int
    let url: String
    let store: Developer
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
