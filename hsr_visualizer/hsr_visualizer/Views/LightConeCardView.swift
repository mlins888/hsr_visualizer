//
//  CharacterCardView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/22/26.
//

import SwiftUI

struct LightConeCardView: View {
    let light_cone: LightCone
    
    var body: some View {
        VStack(spacing: 12) {
            // THE NEW ASYNC IMAGE IMPLEMENTATION
                AsyncImage(url: light_cone.previewURL) { phase in
                    switch phase {
                        
                        // LOADING STATE
                        case .empty:
                            ZStack {
                                Circle().fill(Color.black.opacity(0.4))
                                ProgressView()
                                    .tint(Color(red: 0.85, green: 0.75, blue: 0.55))
                            }
                            .frame(width: 70, height: 70)
                                
                        // THE SUCCESS STATE
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color(red: 0.75, green: 0.59, blue: 0.3), lineWidth: 1.5)
                                )
                                    
                        // ERROR STATE
                        case .failure:
                            ZStack {
                                Circle().fill(Color.red.opacity(0.2))
                                Image(systemName: "person.crop.circle.badge.exclamationmark")
                                    .foregroundStyle(.red)
                            }
                            .frame(width: 70, height: 70)
                                
                        // Required fallback for future iOS updates
                        @unknown default:
                            EmptyView()
                        }
                    }
            
            // 2. Character Details
            VStack(spacing: 4) {
                Text(light_cone.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .lineLimit(1) // Prevents long names from breaking the grid
                
                //Text(character.element)
                    //.font(.caption)
                    //.foregroundStyle(.gray)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity) // Forces all cards in a column to be the same width
        
        // 3. The Glass Background
        .background(.ultraThinMaterial)
        .environment(\.colorScheme, .dark)
        .cornerRadius(16)
        
        // 4. A subtle gold border to match your menu
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 0.75, green: 0.59, blue: 0.3).opacity(0.4), lineWidth: 2)
        )
    }
}

