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

    @State private var pieces: [Relic] = []
    @State private var isLoading = true

    // Slot order used by the in-game inventory.
    private let slotOrder = ["HEAD", "HAND", "BODY", "FOOT", "NECK", "OBJECT"]

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    portraitHeader
                    nameSection

                    if isLoading {
                        ProgressView()
                            .tint(goldText)
                            .padding(.vertical, 40)
                    } else {
                        setBonusCard
                        if !pieces.isEmpty {
                            piecesCard
                        }
                    }

                    Spacer(minLength: 40)
                }
                .padding(.top, 40)
            }
        }
        .task {
            await loadDetails()
        }
    }

    // MARK: - Header

    private var portraitHeader: some View {
        AsyncImage(url: relic_set.iconURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(gold, lineWidth: 2))
                    .shadow(color: gold.opacity(0.4), radius: 20)
            case .failure:
                placeholderPortrait
            default:
                ZStack {
                    Circle().fill(Color.black.opacity(0.5))
                    ProgressView().tint(goldText)
                }
                .frame(width: 200, height: 200)
            }
        }
    }

    private var placeholderPortrait: some View {
        Circle()
            .fill(Color.black.opacity(0.5))
            .frame(width: 200, height: 200)
            .overlay(
                Text(String(relic_set.name.prefix(1)))
                    .font(.system(size: 80, weight: .light))
                    .foregroundStyle(goldText)
            )
            .overlay(Circle().stroke(gold, lineWidth: 2))
    }

    private var nameSection: some View {
        VStack(spacing: 10) {
            Text(relic_set.name)
                .font(.system(size: 36, weight: .heavy))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Set Bonus

    private var setBonusCard: some View {
        sectionCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("Set Bonus")
                    .font(.headline)
                    .foregroundStyle(goldText)

                ForEach(Array(relic_set.desc.enumerated()), id: \.offset) { index, description in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(tierLabel(for: index))
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)

                        if index < relic_set.properties.count, !relic_set.properties[index].isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(Array(relic_set.properties[index].enumerated()), id: \.offset) { _, prop in
                                        tagPill(propertyLabel(prop))
                                    }
                                }
                            }
                        }

                        Text(description)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    if index < relic_set.desc.count - 1 {
                        Divider().background(Color.white.opacity(0.2)).padding(.vertical, 2)
                    }
                }
            }
        }
    }

    // MARK: - Pieces

    private var piecesCard: some View {
        sectionCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("Pieces")
                    .font(.headline)
                    .foregroundStyle(goldText)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(pieces) { piece in
                            pieceTile(piece)
                        }
                    }
                    .padding(.vertical, 2)
                }
            }
        }
    }

    private func pieceTile(_ piece: Relic) -> some View {
        VStack(spacing: 6) {
            AsyncImage(url: piece.iconURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                default:
                    Image(systemName: "shield")
                        .foregroundStyle(goldText)
                }
            }
            .frame(width: 60, height: 60)
            .padding(10)
            .background(Circle().fill(Color.black.opacity(0.4)))
            .overlay(Circle().stroke(gold.opacity(0.4), lineWidth: 1))

            Text(piece.name)
                .font(.caption2.bold())
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)

            Text(slotLabel(piece.type))
                .font(.caption2)
                .foregroundStyle(goldText)

            Text(String(repeating: "★", count: piece.rarity))
                .font(.caption2)
                .foregroundStyle(goldText.opacity(0.8))
        }
        .frame(width: 100)
    }

    // MARK: - Helpers

    private func tierLabel(for index: Int) -> String {
        // 4-piece cavern sets list 2pc + 4pc bonuses; 2-piece planar sets list only a 2pc bonus.
        if relic_set.desc.count > 1 {
            return index == 0 ? "2-Piece Bonus" : "4-Piece Bonus"
        }
        return "2-Piece Bonus"
    }

    private func slotLabel(_ type: String) -> String {
        switch type.uppercased() {
        case "HEAD": return "Head"
        case "HAND": return "Hands"
        case "BODY": return "Body"
        case "FOOT": return "Feet"
        case "NECK": return "Sphere"
        case "OBJECT": return "Rope"
        default: return type.capitalized
        }
    }

    private func propertyLabel(_ prop: RelicSet.Property) -> String {
        let isFlat = prop.type.hasSuffix("Delta")
        let name = statShortName(prop.type)
        if isFlat {
            return "\(name) +\(Int(prop.value.rounded()))"
        }
        let percent = prop.value * 100
        let valueText = percent == floor(percent)
            ? "\(Int(percent))%"
            : String(format: "%.1f%%", percent)
        return "\(name) +\(valueText)"
    }

    private func statShortName(_ type: String) -> String {
        switch type {
        case "HPAddedRatio": return "HP"
        case "AttackAddedRatio": return "ATK"
        case "DefenceAddedRatio": return "DEF"
        case "SpeedDelta": return "SPD"
        case "CriticalChanceBase": return "CRIT Rate"
        case "CriticalDamageBase": return "CRIT DMG"
        case "BreakDamageAddedRatioBase": return "Break Effect"
        case "HealRatioBase": return "Healing"
        case "SPRatioBase": return "Energy Regen"
        case "StatusProbabilityBase": return "Effect Hit"
        case "StatusResistanceBase": return "Effect RES"
        case "PhysicalAddedRatio": return "Physical DMG"
        case "FireAddedRatio": return "Fire DMG"
        case "IceAddedRatio": return "Ice DMG"
        case "ThunderAddedRatio": return "Lightning DMG"
        case "WindAddedRatio": return "Wind DMG"
        case "QuantumAddedRatio": return "Quantum DMG"
        case "ImaginaryAddedRatio": return "Imaginary DMG"
        default: return type
        }
    }

    // MARK: - Data

    private func loadDetails() async {
        let service = StarRailService()
        do {
            let all = try await service.fetchRelic()
            let filtered = all.filter { $0.set_id == relic_set.id }
            // Each slot has one entry per rarity tier; keep only the highest-rarity variant.
            let dedupedBySlot = Dictionary(grouping: filtered, by: { $0.type.uppercased() })
                .compactMapValues { $0.max(by: { $0.rarity < $1.rarity }) }
            self.pieces = dedupedBySlot.values.sorted { lhs, rhs in
                let li = slotOrder.firstIndex(of: lhs.type.uppercased()) ?? Int.max
                let ri = slotOrder.firstIndex(of: rhs.type.uppercased()) ?? Int.max
                return li < ri
            }
        } catch {
            print("[Detail] Relic fetch failed: \(error)")
        }

        self.isLoading = false
    }
}
