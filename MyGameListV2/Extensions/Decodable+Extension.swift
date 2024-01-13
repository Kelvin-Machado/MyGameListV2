//
//  Decodable+Extension.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 07/01/24.
//

import Foundation

extension Decodable {
    static var empty: Self {
        guard let emptyEntity = try? JSONDecoder().decode(Self.self, from: Data()) else {
            fatalError("Failed to create empty entity for type \(Self.self)")
        }
        return emptyEntity
    }
}
