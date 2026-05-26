//
//  StarRailService.swift
//  hsr_visualizer
//
//  Created by Makenna Linsky on 5/21/26.
//

import Foundation

class StarRailService {
    
    func fetchCharacter() async throws -> [StarRailCharacter] {
        guard let url = URL(string: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/characters.json") else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedDictionary = try JSONDecoder().decode([String: StarRailCharacter].self, from: data)
        
        return Array(decodedDictionary.values).sorted { $0.name < $1.name }
    }
    
    func fetchLightCone() async throws -> [LightCone] {
        guard let url = URL(string: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/light_cones.json") else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedDictionary = try JSONDecoder().decode([String: LightCone].self, from: data)

        return Array(decodedDictionary.values).sorted { $0.name < $1.name }
    }
    
    func fetchRelicSet() async throws -> [RelicSet] {
        guard let url = URL(string: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/relic_sets.json") else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedDictionary = try JSONDecoder().decode([String: RelicSet].self, from: data)

        return Array(decodedDictionary.values).sorted { $0.name < $1.name }
    }
}
