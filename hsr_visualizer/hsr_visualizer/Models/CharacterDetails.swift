//
//  CharacterDetails.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/27/26.
//

import Foundation

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

// base stats and ascension costs
struct CharacterPromotion: Codable, Identifiable {
    let id: String
    let values: [PromotionStats]
    let materials: [[MaterialCost]]
    
    struct PromotionStats: Codable {
        let hp: StatValue
        let atk: StatValue
        let def: StatValue
        let spd: StatValue
        let taunt: StatValue
        let critRate: StatValue
        let critDmg: StatValue
        
        enum CodingKeys: String, CodingKey {
            case hp, atk, def, spd, taunt
            case critRate = "crit_rate"
            case critDmg = "crit_dmg"
        }
    }
}

// trace bonuses for eidolon unlock
struct CharacterRank: Codable, Identifiable {
    let id: String
    let name: String
    let rank: Int
    let desc: String
    let materials: [MaterialCost]
    let levelUpSkills: [LevelUpSkill]
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, rank, desc, materials, icon
        case levelUpSkills = "level_up_skills"
    }
    
    struct LevelUpSkill: Codable, Identifiable {
        let id: String
        let num: Int
    }
}

// web of stat nodes and major/minor traces
struct CharacterSkillTree: Codable, Identifiable {
    let id: String
    let name: String
    let maxLevel: Int
    let desc: String
    let anchor: String
    let prePoints: [String]? // Optional because base nodes have no prerequisites
    let levelUpSkills: [CharacterRank.LevelUpSkill]?
    let levels: [TraceLevel]
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, desc, anchor, levels, icon
        case maxLevel = "max_level"
        case prePoints = "pre_points"
        case levelUpSkills = "level_up_skills"
    }
    
    struct TraceLevel: Codable {
        let promotion: Int
        let level: Int
        let materials: [MaterialCost]
        // Note: properties is usually an array of stat boosts (e.g., {"type": "IceAddedRatio", "value": 0.032})
        // If you need it, you can map it to a struct later!
    }
}

// maps out the Basic ATK, Skill, Ultimate, and Talent
struct CharacterSkill: Codable, Identifiable {
    let id: String
    let name: String
    let maxLevel: Int
    let element: String
    let type: String
    let typeText: String
    let effect: String
    let effectText: String
    let simpleDesc: String
    let desc: String
    let params: [[Double]]
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, element, type, effect, desc, params, icon
        case maxLevel = "max_level"
        case typeText = "type_text"
        case effectText = "effect_text"
        case simpleDesc = "simple_desc"
    }
}
