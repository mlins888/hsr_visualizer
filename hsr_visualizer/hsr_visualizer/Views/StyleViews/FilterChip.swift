//
//  FilterChip.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/26/26.
//

import SwiftUI

struct FilterChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    private let gold = Color(red: 0.75, green: 0.59, blue: 0.3)
    private let goldText = Color(red: 0.85, green: 0.75, blue: 0.55)

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(Font.custom("MuseoModerno-Light", size: 12))
                .fontWeight(.semibold)
                .foregroundStyle(isSelected ? Color.black : goldText)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? goldText : Color.white.opacity(0.05))
                )
                .overlay(
                    Capsule()
                        .stroke(gold.opacity(isSelected ? 1 : 0.4), lineWidth: 1.5)
                )
        }
        .buttonStyle(.plain)
    }
}
