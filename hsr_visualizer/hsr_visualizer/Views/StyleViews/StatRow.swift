//
//  StatRow.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/26/26.
//

import SwiftUI

struct StatRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.gray)
                .font(.headline)
            Spacer()
            Text(value)
                .foregroundStyle(.white)
                .font(.headline)
                .fontWeight(.bold)
        }
    }
}
