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
    var displayPath: String {
            return path.translatedPath
        }
    let element: String
    var displayElement: String {
        return element.translatedElement
    }
    let max_sp: Int?
    
    let ranks: [String]
    let skills: [String]
    let skill_trees: [String]
    
    let icon: String
    var iconURL: URL? {
            URL(string: "https://mlins888.github.io/StarRailUpdatedAPI/assets/icon/character/\(id).png")
        }
    let preview: String
    var previewURL: URL? {
            URL(string: "https://mlins888.github.io/StarRailUpdatedAPI/assets/image/character_preview/\(id).png")
        }
    let portrait: String
    var portraitURL: URL? {
            URL(string: "https://mlins888.github.io/StarRailUpdatedAPI/assets/image/character_portrait/\(id).png")
        }
}
