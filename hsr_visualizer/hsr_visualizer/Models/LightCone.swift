//
//  LightCone.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/26/26.
//

import Foundation

struct LightCone: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let rarity: Int
    let path: String
    var displayPath: String {
            return path.translatedPath
        }
    let desc: String
    let icon: String
    var iconURL: URL? {
            URL(string: "https://cdn.jsdelivr.net/gh/Mar-7th/StarRailRes@master/icon/light_cone/\(id).png")
        }
    let preview: String
    var previewURL: URL? {
            URL(string: "https://cdn.jsdelivr.net/gh/Mar-7th/StarRailRes@master/image/light_cone_preview/\(id).png")
        }
    let portrait: String
    var portraitURL: URL? {
            URL(string: "https://cdn.jsdelivr.net/gh/Mar-7th/StarRailRes@master/image/light_cone_portrait/\(id).png")
        }
}
