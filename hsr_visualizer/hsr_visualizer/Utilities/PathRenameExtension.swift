//
//  PathRenameExtension.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/21/26.
//

import Foundation

extension String {
    
    var translatedPath: String {
        switch self {
        case "Knight": return "Preservation"
        case "Warlock": return "Nihility"
        case "Rogue": return "The Hunt"
        case "Mage": return "Erudition"
        case "Warrior": return "Destruction"
        case "Shaman": return "Harmony"
        case "Priest": return "Abundance"
        case "Memory": return "Remembrance"
        case "Muse": return "Elation"
        default: return self
        }
    }

    var translatedElement: String {
        switch self {
        case "Thunder": return "Lightning"
        case "Memory": return "Remembrance"
        default: return self
        }
    }
}
