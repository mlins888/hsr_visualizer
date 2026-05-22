//
//  SimUniverseView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/22/26.
//

import SwiftUI

struct SimUniverseView: View {
    var body: some View {
        ZStack {
            
        }
        
        // BACKGROUND COLORS
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            EllipticalGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.22, green: 0.07, blue: 0.41), location: 0.00),
                    Gradient.Stop(color: .black.opacity(0), location: 1.00),
                ],
                center: UnitPoint(x: 0, y: 0.22)
            )
        )
        .background(
            EllipticalGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.22, green: 0.07, blue: 0.41), location: 0.00),
                    Gradient.Stop(color: .black.opacity(0), location: 1.00),
                ],
                center: UnitPoint(x: 1.3, y: 0.8)
            )
        )
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.1, green: 0.13, blue: 0.21), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.11, green: 0.21, blue: 0.42), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.16, y: -0.01),
                endPoint: UnitPoint(x: 0.65, y: 1)
            )
        )
        .ignoresSafeArea()
    }
}

#Preview {
    SimUniverseView()
}
