//
//  Relic.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/28/26.
//

import Foundation

struct Relic: Codable, Identifiable, Hashable {
    let id: String
    let set_id: String
    let name: String
    let rarity: Int
    let type: String
    let max_level: Int
    let main_affix_id: String
    let sub_affix_id: String
    let icon: String
    var iconURL: URL? {
            URL(string: "https://cdn.jsdelivr.net/gh/Mar-7th/StarRailRes@master/\(icon)")
        }
}
