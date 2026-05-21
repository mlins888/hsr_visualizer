//
//  StarRailService.swift
//  hsr_visualizer
//
//  Created by Makenna Linsky on 5/21/26.
//

import Foundation

class StarRailService {
    
    func fetchCharacter() async throws -> [StarRailCharacter] {
        guard let url = URL(string: "https://vizualabstract.github.io/StarRailStaticAPI/db/en/characters.json") else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedDictionary = try JSONDecoder().decode([String: StarRailCharacter].self, from: data)
        
        return Array(decodedDictionary.values).sorted { $0.name < $1.name }
    }
}
