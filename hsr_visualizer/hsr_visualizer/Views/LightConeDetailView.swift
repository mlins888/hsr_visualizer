//
//  CharacterDetailView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/22/26.
//

import SwiftUI

struct LightConeDetailView: View {
    // This expects the character data passed from the Grid
    let light_cone: LightCone
    
    @State private var promotion: LightConePromotion?
    @State private var ranks: [LightConeRank] = []
    @State private var isLoading = true
    @State private var superimposition = 0

    private let cdnBase = "https://cdn.jsdelivr.net/gh/Mar-7th/StarRailRes@master/"
    
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
                        descCard
                        statsCard
                        if !ranks.isEmpty {
                            passiveCard
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
        AsyncImage(url: light_cone.portraitURL) { phase in
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
                Text(String(light_cone.name.prefix(1)))
                    .font(.system(size: 80, weight: .light))
                    .foregroundStyle(goldText)
            )
            .overlay(Circle().stroke(gold, lineWidth: 2))
    }

    private var nameSection: some View {
        VStack(spacing: 10) {
            Text(light_cone.name)
                .font(.system(size: 36, weight: .heavy))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)

            Text(String(repeating: "★", count: light_cone.rarity))
                .font(.title2)
                .foregroundStyle(goldText)

            HStack(spacing: 10) {
                tagPill(light_cone.displayPath)
            }
        }
    }
    
    //MARK: - Description
    
    private var descCard: some View {
        sectionCard {
            VStack(alignment: .leading, spacing: 14) {
                Text(light_cone.desc)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    
    // MARK: - Stats

    private var statsCard: some View {
        sectionCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("Base Stats (Max Level)")
                    .font(.headline)
                    .foregroundStyle(goldText)

                if let last = promotion?.values.last {
                    statBar(label: "HP", value: maxStat(last.hp), max: 2000, color: Color.green)
                    statBar(label: "ATK", value: maxStat(last.atk), max: 1000, color: Color.red)
                    statBar(label: "DEF", value: maxStat(last.def), max: 1000, color: Color.blue)
                } else {
                    Text("Stats unavailable")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                }
            }
        }
    }

    private func statBar(label: String, value: Int, max: Int, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                Spacer()
                Text("\(value)")
                    .foregroundStyle(.white)
                    .font(.subheadline.bold())
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.08))
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [color.opacity(0.6), color],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geo.size.width * min(1, Double(value) / Double(max)))
                }
            }
            .frame(height: 6)
        }
    }
    
    
    // MARK: - Passive Stuff
    private var passiveCard: some View {
        sectionCard {
            VStack(alignment: .leading, spacing: 12) {
                if let rank = ranks.first {
                    Text("Passive Ability")
                        .font(.caption)
                        .foregroundStyle(goldText)

                    Text(rank.skill)
                        .font(.headline)
                        .foregroundStyle(.white)

                    if rank.params.count > 1 {
                        Picker("Superimposition", selection: $superimposition) {
                            ForEach(0..<rank.params.count, id: \.self) { i in
                                Text("S\(i + 1)").tag(i)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    Text(formattedDesc(rank))
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.85))
                        .fixedSize(horizontal: false, vertical: true)
                } else {
                    Text("Passive ability unavailable")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                }
            }
        }
    }

    // Replaces #1[i], #2[f1] etc. in desc with values from params[superimposition].
    // [i]  -> raw * 100, rounded to int (percent display).
    // [fN] -> raw * 100, formatted with N decimals.
    private func formattedDesc(_ rank: LightConeRank) -> String {
        let level = min(superimposition, rank.params.count - 1)
        guard level >= 0 else { return rank.desc }
        let values = rank.params[level]
        var result = rank.desc
        let pattern = #"#(\d+)\[([^\]]+)\]"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return result }
        let matches = regex.matches(in: result, range: NSRange(result.startIndex..., in: result))
        for match in matches.reversed() {
            guard let fullRange = Range(match.range, in: result),
                  let idxRange = Range(match.range(at: 1), in: result),
                  let fmtRange = Range(match.range(at: 2), in: result),
                  let oneBased = Int(result[idxRange]) else { continue }
            let idx = oneBased - 1
            guard idx >= 0, idx < values.count else { continue }
            let raw = values[idx]
            let fmt = String(result[fmtRange])
            let display: String
            if fmt == "i" {
                display = "\(Int((raw * 100).rounded()))"
            } else if fmt.hasPrefix("f"), let decimals = Int(fmt.dropFirst()) {
                display = String(format: "%.\(decimals)f%", raw * 100)
            } else {
                display = String(raw)
            }
            result.replaceSubrange(fullRange, with: display)
        }
        return result
    }


    // MARK: - Data

    private func maxStat(_ stat: StatValue) -> Int {
        // Last promotion entry covers the top 10 levels of progression.
        Int((stat.base + stat.step * 10).rounded())
    }
    
    private func loadDetails() async {
        let service = StarRailService()
        async let promotions = service.fetchLightConePromotion()
        async let allRanks = service.fetchLightConeRank()

        do {
            let p = try await promotions
            print("[Detail] promotions loaded: \(p.count). character.id='\(light_cone.id)' match=\(p.contains { $0.id == light_cone.id })")
            self.promotion = p.first(where: { $0.id == light_cone.id })
        } catch {
            print("[Detail] Promotion fetch failed: \(error)")
        }

        do {
            let r = try await allRanks
            if let match = r.first(where: { $0.id == light_cone.id }) {
                self.ranks = [match]
            }
        } catch {
            print("[Detail] Rank fetch failed: \(error)")
        }

        self.isLoading = false
    }

}
