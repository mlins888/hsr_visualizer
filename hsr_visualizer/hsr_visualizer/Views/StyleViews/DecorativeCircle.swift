//
//  DecorativeCircle.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/22/26.
//
import SwiftUI

struct DecorativeCircle: View {
    var body: some View {
        Circle()
            .stroke(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.35, green: 0.27, blue: 0.14), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.83, green: 0.69, blue: 0.42), location: 1.00),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1.5
            )
            .frame(width: 366, height: 366)
    }
}

#Preview {
    DecorativeCircle()
        .preferredColorScheme(.dark)
}
