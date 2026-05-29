//
//  CharacterDetailView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/22/26.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: StarRailCharacter

    @State private var promotion: CharacterPromotion?
    @State private var skills: [CharacterSkill] = []
    @State private var ranks: [CharacterRank] = []
    @State private var isLoading = true
    @State private var selectedSkillID: String?

    private let cdnBase = "https://cdn.jsdelivr.net/gh/Mar-7th/StarRailRes@master/"

    private var selectedSkill: CharacterSkill? {
        if let id = selectedSkillID {
            return skills.first(where: { $0.id == id })
        }
        return skills.first
    }

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
                        statsCard
                        if !skills.isEmpty {
                            skillsCard
                        }
                        if !ranks.isEmpty {
                            eidolonsCard
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
        AsyncImage(url: character.portraitURL) { phase in
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
                Text(String(character.name.prefix(1)))
                    .font(.system(size: 80, weight: .light))
                    .foregroundStyle(goldText)
            )
            .overlay(Circle().stroke(gold, lineWidth: 2))
    }

    private var nameSection: some View {
        VStack(spacing: 10) {
            Text(character.name)
                .font(.system(size: 36, weight: .heavy))
                .foregroundStyle(.white)

            Text(String(repeating: "★", count: character.rarity))
                .font(.title2)
                .foregroundStyle(goldText)

            HStack(spacing: 10) {
                tagPill(character.displayElement)
                tagPill(character.displayPath)
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
                    statBar(label: "SPD", value: maxStat(last.spd), max: 200, color: Color.yellow)

                    Divider().background(Color.white.opacity(0.2)).padding(.vertical, 2)

                    StatRow(title: "Crit Rate", value: String(format: "%.1f%%", last.critRate.base * 100))
                    StatRow(title: "Crit DMG", value: String(format: "%.1f%%", last.critDmg.base * 100))
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

    // MARK: - Skills

    private var skillsCard: some View {
        sectionCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("Abilities")
                    .font(.headline)
                    .foregroundStyle(goldText)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(skills) { skill in
                            skillTile(skill)
                        }
                    }
                    .padding(.vertical, 2)
                }

                if let selected = selectedSkill {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(selected.name)
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                        Text(selected.typeText)
                            .font(.caption)
                            .foregroundStyle(goldText)
                        Text(selected.simpleDesc.isEmpty ? selected.desc : selected.simpleDesc)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.top, 4)
                }
            }
        }
    }

    private func skillTile(_ skill: CharacterSkill) -> some View {
        let isSelected = (selectedSkill?.id == skill.id)
        let url = skill.icon.flatMap { URL(string: cdnBase + $0) }
        return Button {
            selectedSkillID = skill.id
        } label: {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                default:
                    Image(systemName: "sparkles")
                        .foregroundStyle(goldText)
                }
            }
            .frame(width: 50, height: 50)
            .padding(10)
            .background(Circle().fill(Color.black.opacity(0.4)))
            .overlay(
                Circle().stroke(isSelected ? gold : gold.opacity(0.3), lineWidth: isSelected ? 2 : 1)
            )
            .shadow(color: isSelected ? gold.opacity(0.5) : .clear, radius: 8)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Eidolons

    private var eidolonsCard: some View {
        sectionCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("Eidolons")
                    .font(.headline)
                    .foregroundStyle(goldText)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(ranks) { rank in
                            eidolonTile(rank)
                        }
                    }
                    .padding(.vertical, 2)
                }
            }
        }
    }

    private func eidolonTile(_ rank: CharacterRank) -> some View {
        VStack(spacing: 6) {
            AsyncImage(url: URL(string: cdnBase + rank.icon)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                default:
                    Image(systemName: "diamond")
                        .foregroundStyle(goldText)
                }
            }
            .frame(width: 44, height: 44)
            .padding(10)
            .background(Circle().fill(Color.black.opacity(0.4)))
            .overlay(Circle().stroke(gold.opacity(0.4), lineWidth: 1))

            Text("E\(rank.rank)")
                .font(.caption2.bold())
                .foregroundStyle(goldText)
        }
    }

    
    // MARK: - Data

    private func maxStat(_ stat: StatValue) -> Int {
        // Last promotion entry covers the top 10 levels of progression.
        Int((stat.base + stat.step * 10).rounded())
    }

    private func loadDetails() async {
        let service = StarRailService()
        async let promotions = service.fetchCharacterPromotion()
        async let allSkills = service.fetchCharacterSkill()
        async let allRanks = service.fetchCharacterRank()

        do {
            let p = try await promotions
            print("[Detail] promotions loaded: \(p.count). character.id='\(character.id)' match=\(p.contains { $0.id == character.id })")
            self.promotion = p.first(where: { $0.id == character.id })
        } catch {
            print("[Detail] Promotion fetch failed: \(error)")
        }

        do {
            let s = try await allSkills
            let skillIDSet = Set(character.skills)
            self.skills = s.filter { skillIDSet.contains($0.id) }
                .sorted { lhs, rhs in
                    let li = character.skills.firstIndex(of: lhs.id) ?? Int.max
                    let ri = character.skills.firstIndex(of: rhs.id) ?? Int.max
                    return li < ri
                }
        } catch {
            print("[Detail] Skill fetch failed: \(error)")
        }

        do {
            let r = try await allRanks
            let rankIDSet = Set(character.ranks)
            self.ranks = r.filter { rankIDSet.contains($0.id) }
                .sorted { $0.rank < $1.rank }
        } catch {
            print("[Detail] Rank fetch failed: \(error)")
        }

        self.isLoading = false
    }
}
