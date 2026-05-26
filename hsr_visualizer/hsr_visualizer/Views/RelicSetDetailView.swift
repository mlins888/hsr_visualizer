//
//  CharacterDetailView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/22/26.
//

import SwiftUI

struct RelicSetDetailView: View {
    // This expects the character data passed from the Grid
    let relic_set: RelicSet
    
    var body: some View {
        ZStack {
            // 1. Deep Space Background
            Color(red: 0.05, green: 0.05, blue: 0.1)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // 2. The Avatar / Portrait Header
                    Circle()
                        .fill(Color.black.opacity(0.5))
                        .frame(width: 150, height: 150)
                        .overlay(
                            Text(String(relic_set.name.prefix(1)))
                                .font(.system(size: 60, weight: .light))
                                .foregroundStyle(Color(red: 0.85, green: 0.75, blue: 0.55))
                        )
                        .overlay(
                            Circle().stroke(Color(red: 0.75, green: 0.59, blue: 0.3), lineWidth: 2)
                        )
                        .shadow(color: Color(red: 0.75, green: 0.59, blue: 0.3).opacity(0.3), radius: 20, x: 0, y: 0)
                    
                    // 3. Name and Title
                    VStack(spacing: 8) {
                        Text(relic_set.name)
                            .font(.system(size: 40, weight: .heavy))
                            .foregroundStyle(.white)
                        
                        //Text(String(repeating: "★", count: character.rarity))
                            //.font(.title2)
                            //.foregroundStyle(Color(red: 0.85, green: 0.75, blue: 0.55))
                    }
                    
                    // 4. The Stats Card (Using your Glass UI style)
                    VStack(spacing: 16) {
                        StatRow(title: "Description", value: relic_set.desc.joined(separator: "\n\n"))
                        Divider().background(Color.white.opacity(0.2))
                    }
                    .padding(24)
                    .background(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
                    .cornerRadius(24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .padding(.top, 40)
            }
        }
    }
}
