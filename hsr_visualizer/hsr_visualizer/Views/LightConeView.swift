//
//  LightConeView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/22/26.
//

import SwiftUI

struct LightConeView: View {
    @State private var light_cones: [LightCone] = []
    @State private var isLoading = true
    
    // Filter & sort state
    @State private var selectedPath: EnumPath? = nil
    @State private var sortOption: LightConeSortOption = .alphabetical
    
    @State private var searchText = ""
    
    // 1. Define the Grid Layout (Two flexible columns)
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 30)
    ]
    
    private var displayedLightCones: [LightCone] {
        var result = light_cones

        if let path = selectedPath {
            result = result.filter { $0.displayPath == path.rawValue }
        }
        
        if !searchText.isEmpty {
            result = result.filter { $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sortOption {
        case .alphabetical:
            result.sort { $0.name < $1.name }
        case .reverseAlphabetical:
            result.sort { $0.name > $1.name }
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
                            ForEach(displayedLightCones) { light_cone in
                                NavigationLink(destination: LightConeDetailView(light_cone: light_cone)) {
                                    LightConeCardView(light_cone: light_cone)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(16)
                    }
                    .searchable(text: $searchText, prompt: "Search light cones...")
                }
            }
        }
        .navigationTitle("Light Cones")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Picker("Sort by", selection: $sortOption) {
                        ForEach(LightConeSortOption.allCases, id: \.self) { option in
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
                self.light_cones = try await service.fetchLightCone()
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
    LightConeView()
}
