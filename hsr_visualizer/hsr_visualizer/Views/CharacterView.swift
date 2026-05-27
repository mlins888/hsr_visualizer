//
//  CharacterView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/22/26.
//

import SwiftUI

struct CharacterView: View {
    // State variables for data fetching
    @State private var characters: [StarRailCharacter] = []
    @State private var isLoading = true

    // Filter & sort state
    @State private var selectedElement: CharacterElement? = nil
    @State private var selectedPath: EnumPath? = nil
    @State private var sortOption: SortOption = .alphabetical

    // 1. Define the Grid Layout (Two flexible columns)
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 30)
    ]

    private var displayedCharacters: [StarRailCharacter] {
        var result = characters

        if let element = selectedElement {
            result = result.filter { $0.displayElement == element.rawValue }
        }
        if let path = selectedPath {
            result = result.filter { $0.displayPath == path.rawValue }
        }

        switch sortOption {
        case .alphabetical:
            result.sort { $0.name < $1.name }
        case .reverseAlphabetical:
            result.sort { $0.name > $1.name }
        case .byElement:
            result.sort { $0.displayElement == $1.displayElement ? $0.name < $1.name : $0.displayElement < $1.displayElement }
        case .byPath:
            result.sort { $0.displayPath == $1.displayPath ? $0.name < $1.name : $0.displayPath < $1.displayPath }
        case .rarityDesc:
            result.sort { $0.rarity == $1.rarity ? $0.name < $1.name : $0.rarity > $1.rarity }
        case .rarityAsc:
            result.sort { $0.rarity == $1.rarity ? $0.name < $1.name : $0.rarity < $1.rarity }
        }

        return result
    }

    var body: some View {
        ZStack {
            AppBackground()

            if isLoading {
                ProgressView("Accessing Data Bank...")
                    .foregroundStyle(Color(red: 0.85, green: 0.75, blue: 0.55))
            } else {
                VStack(spacing: 12) {
                    filterChipBar
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(displayedCharacters) { character in
                                NavigationLink(destination: CharacterDetailView(character: character)) {
                                    CharacterCardView(character: character)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(16)
                    }
                }
            }
        }
        .navigationTitle("Characters")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Picker("Sort by", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down.circle")
                        .foregroundStyle(Color(red: 0.85, green: 0.75, blue: 0.55))
                }
            }
        }
        .task {
            do {
                let service = StarRailService()
                self.characters = try await service.fetchCharacter()
                self.isLoading = false
            } catch {
                print("Failed to load data: \(error)")
                self.isLoading = false
            }
        }
    }

    private var filterChipBar: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    FilterChip(label: "All Elements", isSelected: selectedElement == nil) {
                        selectedElement = nil
                    }
                    ForEach(CharacterElement.allCases, id: \.self) { element in
                        FilterChip(label: element.rawValue, isSelected: selectedElement == element) {
                            selectedElement = (selectedElement == element) ? nil : element
                        }
                    }
                }
                .padding(.horizontal, 16)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    FilterChip(label: "All Paths", isSelected: selectedPath == nil) {
                        selectedPath = nil
                    }
                    ForEach(EnumPath.allCases, id: \.self) { path in
                        FilterChip(label: path.rawValue, isSelected: selectedPath == path) {
                            selectedPath = (selectedPath == path) ? nil : path
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.top, 8)
    }
}

#Preview {
    CharacterView()
}
