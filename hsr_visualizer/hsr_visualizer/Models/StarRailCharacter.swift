//
//  Character.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/20/26.
//

import Foundation

struct StarRailCharacter: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let tag: String
    let rarity: Int
    let path: String
    let element: String
    let max_sp: Int
    
    let ranks: [String]
    let skills: [String]
    let skill_trees: [String]
    
    let icon: String
    let preview: String
    let portrait: String
}
