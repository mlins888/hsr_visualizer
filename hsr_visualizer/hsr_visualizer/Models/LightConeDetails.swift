//
//  LightConeDetails.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/28/26.
//

struct LightConePromotion: Codable, Identifiable {
    let id: String
    let values: [PromotionStats]
    let materials: [[MaterialCost]]
    
    struct PromotionStats: Codable {
        let hp: StatValue
        let atk: StatValue
        let def: StatValue
        
        enum CodingKeys: String, CodingKey {
            case hp, atk, def
        }
    }
}

// trace bonuses for eidolon unlock
struct LightConeRank: Codable, Identifiable {
    let id: String
    let skill: String
    let desc: String
    let params: [[Double]]
    let properties: [[RankProperty]]
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, skill, desc, params, properties, icon
    }

    struct RankProperty: Codable {
        let type: String
        let value: Double
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(String.self, forKey: .id)
        skill = try c.decodeIfPresent(String.self, forKey: .skill) ?? ""
        desc = try c.decodeIfPresent(String.self, forKey: .desc) ?? ""
        params = try c.decodeIfPresent([[Double]].self, forKey: .params) ?? []
        properties = try c.decodeIfPresent([[RankProperty]].self, forKey: .properties) ?? []
        icon = try c.decodeIfPresent(String.self, forKey: .icon) ?? ""
    }
}
