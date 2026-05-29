//
//  CharacterView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/22/26.
//

import SwiftUI

struct RelicSetView: View {
    // State variables for data fetching
    @State private var relic_sets: [RelicSet] = []
    @State private var isLoading = true

    @State private var searchText = ""

    // 1. Define the Grid Layout (Two flexible columns)
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 30)
    ]

    private var displayedRelicSets: [RelicSet] {
        guard !searchText.isEmpty else { return relic_sets }
        return relic_sets.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        ZStack {
            AppBackground()

            if isLoading {
                ProgressView("Accessing Data Bank...")
                    .foregroundStyle(Color(red: 0.85, green: 0.75, blue: 0.55))
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(displayedRelicSets) { relic_set in
                            NavigationLink(destination: RelicSetDetailView(relic_set: relic_set)) {
                                RelicSetCardView(relic_set: relic_set)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(16)
                }
                .searchable(text: $searchText, prompt: "Search relic sets...")
            }
        }
        .navigationTitle("Relic Sets")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .task {
            do {
                let service = StarRailService()
                self.relic_sets = try await service.fetchRelicSet()
                self.isLoading = false
            } catch {
                print("Failed to load data: \(error)")
                self.isLoading = false
            }
        }
    }
}

#Preview {
    RelicSetView()
}
