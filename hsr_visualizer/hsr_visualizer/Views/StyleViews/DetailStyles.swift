//
//  DetailStyles.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/28/26.
//
import SwiftUI

let gold = Color(red: 0.75, green: 0.59, blue: 0.3)
let goldText = Color(red: 0.85, green: 0.75, blue: 0.55)

func tagPill(_ text: String) -> some View {
    Text(text)
        .font(.subheadline)
        .foregroundStyle(goldText)
        .padding(.horizontal, 14)
        .padding(.vertical, 6)
        .background(Capsule().fill(Color.white.opacity(0.08)))
        .overlay(Capsule().stroke(gold.opacity(0.5), lineWidth: 1))
}

func sectionCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    content()
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .environment(\.colorScheme, .dark)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .padding(.horizontal, 20)
}
