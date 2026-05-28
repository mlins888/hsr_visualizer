//
//  DetailsStructs.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/28/26.
//

// Used every time the API lists an item requirement
struct MaterialCost: Codable, Identifiable {
    let id: String
    let num: Int
}

// Used to define stat growth rates
struct StatValue: Codable {
    let base: Double
    let step: Double
}
