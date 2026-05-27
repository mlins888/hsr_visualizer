//
//  EnumFile.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/26/26.
//


enum CharacterElement: String, CaseIterable {
    case fire = "Fire"
    case quantum = "Quantum"
    case ice = "Ice"
    case physical = "Physical"
    case lightning = "Lightning"
    case wind = "Wind"
    case imaginary = "Imaginary"
}

enum EnumPath: String, CaseIterable {
    case preservation = "Preservation"
    case nihility = "Nihility"
    case hunt = "The Hunt"
    case erudition = "Erudition"
    case destruction = "Destruction"
    case harmony = "Harmony"
    case abundance = "Abundance"
    case elation = "Elation"
    case remembrance = "Remembrance"
}

enum Rarity: String, CaseIterable {
    case five_star = "★★★★★"
    case four_star = "★★★★"
    case three_star = "★★★"
    case two_star = "★★"
    case one_star = "★"
}

enum SortOption: String, CaseIterable {
    case alphabetical = "A-Z"
    case reverseAlphabetical = "Z-A"
    case byElement = "Element"
    case byPath = "Path"
    case rarityDesc = "Rarity (High to Low)"
    case rarityAsc = "Rarity (Low to High)"
}

enum LightConeSortOption: String, CaseIterable {
    case alphabetical = "A-Z"
    case reverseAlphabetical = "Z-A"
    case byPath = "Path"
    case rarityDesc = "Rarity (High to Low)"
    case rarityAsc = "Rarity (Low to High)"
}
