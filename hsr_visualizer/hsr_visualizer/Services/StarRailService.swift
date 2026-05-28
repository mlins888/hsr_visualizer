//
//  StarRailService.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/21/26.
//

import Foundation

class StarRailService {

    // In-memory caches: hold for the lifetime of the app session so navigating
    // back and forth between views doesn't refetch the same JSON.
    private static var charactersCache: [StarRailCharacter]?
    private static var lightConesCache: [LightCone]?
    private static var relicSetsCache: [RelicSet]?
    private static var promotionsCache: [CharacterPromotion]?
    private static var ranksCache: [CharacterRank]?
    private static var skillTreesCache: [CharacterSkillTree]?
    private static var skillsCache: [CharacterSkill]?
    private static var conePromotionsCache: [LightConePromotion]?
    private static var coneRanksCache: [LightConeRank]?

    private func fetchJSON<T: Decodable>(from urlString: String) async throws -> [String: T] {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([String: T].self, from: data)
    }

    func fetchCharacter() async throws -> [StarRailCharacter] {
        if let cached = Self.charactersCache { return cached }
        let decoded: [String: StarRailCharacter] = try await fetchJSON(
            from: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/characters.json"
        )
        let result = Array(decoded.values).sorted { $0.name < $1.name }
        Self.charactersCache = result
        return result
    }

    func fetchLightCone() async throws -> [LightCone] {
        if let cached = Self.lightConesCache { return cached }
        let decoded: [String: LightCone] = try await fetchJSON(
            from: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/light_cones.json"
        )
        let result = Array(decoded.values).sorted { $0.name < $1.name }
        Self.lightConesCache = result
        return result
    }

    func fetchRelicSet() async throws -> [RelicSet] {
        if let cached = Self.relicSetsCache { return cached }
        let decoded: [String: RelicSet] = try await fetchJSON(
            from: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/relic_sets.json"
        )
        let result = Array(decoded.values).sorted { $0.name < $1.name }
        Self.relicSetsCache = result
        return result
    }

    func fetchCharacterPromotion() async throws -> [CharacterPromotion] {
        if let cached = Self.promotionsCache { return cached }
        let decoded: [String: CharacterPromotion] = try await fetchJSON(
            from: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/character_promotions.json"
        )
        let result = Array(decoded.values).sorted { $0.id < $1.id }
        Self.promotionsCache = result
        return result
    }

    func fetchCharacterRank() async throws -> [CharacterRank] {
        if let cached = Self.ranksCache { return cached }
        let decoded: [String: CharacterRank] = try await fetchJSON(
            from: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/character_ranks.json"
        )
        let result = Array(decoded.values).sorted { $0.id < $1.id }
        Self.ranksCache = result
        return result
    }

    func fetchCharacterSkillTree() async throws -> [CharacterSkillTree] {
        if let cached = Self.skillTreesCache { return cached }
        let decoded: [String: CharacterSkillTree] = try await fetchJSON(
            from: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/character_skill_trees.json"
        )
        let result = Array(decoded.values).sorted { $0.id < $1.id }
        Self.skillTreesCache = result
        return result
    }

    func fetchCharacterSkill() async throws -> [CharacterSkill] {
        if let cached = Self.skillsCache { return cached }
        let decoded: [String: CharacterSkill] = try await fetchJSON(
            from: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/character_skills.json"
        )
        let result = Array(decoded.values).sorted { $0.id < $1.id }
        Self.skillsCache = result
        return result
    }
    
    func fetchLightConePromotion() async throws -> [LightConePromotion] {
        if let cached = Self.conePromotionsCache { return cached }
        let decoded: [String: LightConePromotion] = try await fetchJSON(
            from: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/light_cone_promotions.json"
        )
        let result = Array(decoded.values).sorted { $0.id < $1.id }
        Self.conePromotionsCache = result
        return result
    }

    func fetchLightConeRank() async throws -> [LightConeRank] {
        if let cached = Self.coneRanksCache { return cached }
        let decoded: [String: LightConeRank] = try await fetchJSON(
            from: "https://mlins888.github.io/StarRailUpdatedAPI/db/en/light_cone_ranks.json"
        )
        let result = Array(decoded.values).sorted { $0.id < $1.id }
        Self.coneRanksCache = result
        return result
    }

}
