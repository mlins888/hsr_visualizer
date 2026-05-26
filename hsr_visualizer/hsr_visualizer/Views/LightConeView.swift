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
    
    // 1. Define the Grid Layout (Two flexible columns)
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 30)
    ]
    
    var body: some View {
        ZStack {
            AppBackground()
            
            if isLoading {
                ProgressView("Accessing Data Bank...")
                    .foregroundStyle(Color(red: 0.85, green: 0.75, blue: 0.55))
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(light_cones) { light_cone in
                            NavigationLink(destination: LightConeDetailView(light_cone: light_cone)) {
                                LightConeCardView(light_cone: light_cone)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationTitle("Light Cones")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
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
}

#Preview {
    LightConeView()
}
