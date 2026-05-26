//
//  RelicSet.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/26/26.
//

import Foundation

struct RelicSet: Codable, Identifiable, Hashable {
    struct Property: Codable, Hashable {
        let type: String
        let value: Double
    }

    let id: String
    let name: String
    let desc: [String]
    let properties: [[Property]]
    let icon: String
    var iconURL: URL? {
            URL(string: "https://mlins888.github.io/StarRailUpdatedAPI/assets/icon/relic/\(id).png")
        }
}
