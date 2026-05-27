//
//  AnalyticsView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/27/26.
//

import SwiftUI
import Charts

struct AnalyticsView: View {
    
    @State private var characters: [StarRailCharacter] = []
    @State private var light_cones: [LightCone] = []
    @State private var isLoading = true
    
    var elementDistribution: [(element: String, count: Int)] {
        let grouped = Dictionary(grouping: characters, by: { $0.displayElement })
        return grouped.map { (element: $0.key, count: $0.value.count) }.sorted { $0.count > $1.count }
    }
    
    var charPathDistribution: [(path: String, count: Int)] {
        let grouped = Dictionary(grouping: characters, by: { $0.displayPath })
        return grouped.map { (path: $0.key, count: $0.value.count) }.sorted { $0.count > $1.count }
    }
    
    var conePathDistribution: [(path: String, count: Int)] {
        let grouped = Dictionary(grouping: light_cones, by: { $0.displayPath })
        return grouped.map { (path: $0.key, count: $0.value.count) }.sorted { $0.count > $1.count }
    }
    
    var body: some View {
        ZStack {
            AppBackground()
            
            if isLoading {
                ProgressView("Accessing Data Bank...")
                    .foregroundStyle(Color(red: 0.85, green: 0.75, blue: 0.55))
            } else {
                VStack(alignment: .center, spacing: 20) {
                    ScrollView {
                        Text("Current Character Element Distribution")
                            .font(Font.custom("MuseoModerno-Light", size: 24))
                            .bold()
                            .foregroundStyle(Color(red: 0.83, green: 0.69, blue: 0.42))
                            .multilineTextAlignment(.center)
                        Chart {
                            ForEach(elementDistribution, id: \.element) { dataPoint in
                                BarMark(
                                    x: .value("Element", dataPoint.element),
                                    y: .value("Total", dataPoint.count)
                                )
                                .foregroundStyle(by: .value("Element", dataPoint.element))
                                .cornerRadius(4)
                            }
                        }
                        .chartForegroundStyleScale([
                            "Physical": Color(red: 0.5373, green: 0.5373, blue: 0.5373),
                            "Fire": Color(red: 0.9098, green: 0.2627, blue: 0.2745),
                            "Ice": Color(red: 0.2745, green: 0.6745, blue: 0.9569),
                            "Lightning": Color(red: 0.6157, green: 0.2235, blue: 0.8275),
                            "Wind": Color(red: 0.2588, green: 0.8196, blue: 0.549),
                            "Quantum": Color(red: 0.2549, green: 0.2431, blue: 0.6275),
                            "Imaginary": Color(red: 0.9373, green: 0.8196, blue: 0.298)
                        ])
                        .frame(height: 300)
                        .padding()
                        .background(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.85, green: 0.75, blue: 0.55).opacity(0.4), lineWidth: 1)
                        )
                        
                        Chart {
                            ForEach(elementDistribution, id: \.element) { dataPoint in
                                SectorMark(
                                    angle: .value("Total", dataPoint.count),
                                    innerRadius: .ratio(0.6),
                                    angularInset: 1.5
                                )
                                .foregroundStyle(by: .value("Element", dataPoint.element))
                            }
                        }
                        .chartForegroundStyleScale([
                            "Physical": Color(red: 0.5373, green: 0.5373, blue: 0.5373),
                            "Fire": Color(red: 0.9098, green: 0.2627, blue: 0.2745),
                            "Ice": Color(red: 0.2745, green: 0.6745, blue: 0.9569),
                            "Lightning": Color(red: 0.6157, green: 0.2235, blue: 0.8275),
                            "Wind": Color(red: 0.2588, green: 0.8196, blue: 0.549),
                            "Quantum": Color(red: 0.2549, green: 0.2431, blue: 0.6275),
                            "Imaginary": Color(red: 0.9373, green: 0.8196, blue: 0.298)
                        ])
                        .frame(height: 300)
                        .padding()
                        .background(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.85, green: 0.75, blue: 0.55).opacity(0.4), lineWidth: 1)
                        )
                        .padding(.bottom, 40)
                        
                        
                        Text("Current Character Path Distribution")
                            .font(Font.custom("MuseoModerno-Light", size: 24))
                            .bold()
                            .foregroundStyle(Color(red: 0.83, green: 0.69, blue: 0.42))
                            .multilineTextAlignment(.center)
                        Chart {
                            ForEach(charPathDistribution, id: \.path) { dataPoint in
                                BarMark(
                                    x: .value("Path", dataPoint.path),
                                    y: .value("Total", dataPoint.count)
                                )
                                .foregroundStyle(by: .value("Path", dataPoint.path))
                                .cornerRadius(4)
                            }
                        }
                        .chartForegroundStyleScale([
                            "Destruction": Color(red: 0.5373, green: 0.5373, blue: 0.5373),
                            "Elation": Color(red: 0.9098, green: 0.2627, blue: 0.2745),
                            "Remembrance": Color(red: 0.2745, green: 0.6745, blue: 0.9569),
                            "Erudition": Color(red: 0.6157, green: 0.2235, blue: 0.8275),
                            "The Hunt": Color(red: 0.2588, green: 0.8196, blue: 0.549),
                            "Nihility": Color(red: 0.2549, green: 0.2431, blue: 0.6275),
                            "Abundance": Color(red: 0.9373, green: 0.8196, blue: 0.298),
                            "Preservation": Color(red: 0.8588, green: 0.4392, blue: 0.3765),
                            "Harmony": Color(red: 0.5333, green: 0.4157, blue: 0.7882)
                        ])
                        .frame(height: 300)
                        .padding()
                        .background(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.85, green: 0.75, blue: 0.55).opacity(0.4), lineWidth: 1)
                        )
                        
                        Chart {
                            ForEach(charPathDistribution, id: \.path) { dataPoint in
                                SectorMark(
                                    angle: .value("Total", dataPoint.count),
                                    innerRadius: .ratio(0.6),
                                    angularInset: 1.5
                                )
                                .foregroundStyle(by: .value("Path", dataPoint.path))
                            }
                        }
                        .chartForegroundStyleScale([
                            "Destruction": Color(red: 0.5373, green: 0.5373, blue: 0.5373),
                            "Elation": Color(red: 0.9098, green: 0.2627, blue: 0.2745),
                            "Remembrance": Color(red: 0.2745, green: 0.6745, blue: 0.9569),
                            "Erudition": Color(red: 0.6157, green: 0.2235, blue: 0.8275),
                            "The Hunt": Color(red: 0.2588, green: 0.8196, blue: 0.549),
                            "Nihility": Color(red: 0.2549, green: 0.2431, blue: 0.6275),
                            "Abundance": Color(red: 0.9373, green: 0.8196, blue: 0.298),
                            "Preservation": Color(red: 0.8588, green: 0.4392, blue: 0.3765),
                            "Harmony": Color(red: 0.5333, green: 0.4157, blue: 0.7882)
                        ])
                        .frame(height: 300)
                        .padding()
                        .background(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.85, green: 0.75, blue: 0.55).opacity(0.4), lineWidth: 1)
                        )
                        .padding(.bottom, 40)
                        
                        
                        Text("Current Light Cone Path Distribution")
                            .font(Font.custom("MuseoModerno-Light", size: 24))
                            .bold()
                            .foregroundStyle(Color(red: 0.83, green: 0.69, blue: 0.42))
                            .multilineTextAlignment(.center)
                        Chart {
                            ForEach(conePathDistribution, id: \.path) { dataPoint in
                                BarMark(
                                    x: .value("Path", dataPoint.path),
                                    y: .value("Total", dataPoint.count)
                                )
                                .foregroundStyle(by: .value("Path", dataPoint.path))
                                .cornerRadius(4)
                            }
                        }
                        .chartForegroundStyleScale([
                            "Destruction": Color(red: 0.5373, green: 0.5373, blue: 0.5373),
                            "Elation": Color(red: 0.9098, green: 0.2627, blue: 0.2745),
                            "Remembrance": Color(red: 0.2745, green: 0.6745, blue: 0.9569),
                            "Erudition": Color(red: 0.6157, green: 0.2235, blue: 0.8275),
                            "The Hunt": Color(red: 0.2588, green: 0.8196, blue: 0.549),
                            "Nihility": Color(red: 0.2549, green: 0.2431, blue: 0.6275),
                            "Abundance": Color(red: 0.9373, green: 0.8196, blue: 0.298),
                            "Preservation": Color(red: 0.8588, green: 0.4392, blue: 0.3765),
                            "Harmony": Color(red: 0.5333, green: 0.4157, blue: 0.7882)
                        ])
                        .frame(height: 300)
                        .padding()
                        .background(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.85, green: 0.75, blue: 0.55).opacity(0.4), lineWidth: 1)
                        )
                        
                        Chart {
                            ForEach(conePathDistribution, id: \.path) { dataPoint in
                                SectorMark(
                                    angle: .value("Total", dataPoint.count),
                                    innerRadius: .ratio(0.6),
                                    angularInset: 1.5
                                )
                                .foregroundStyle(by: .value("Path", dataPoint.path))
                            }
                        }
                        .chartForegroundStyleScale([
                            "Destruction": Color(red: 0.5373, green: 0.5373, blue: 0.5373),
                            "Elation": Color(red: 0.9098, green: 0.2627, blue: 0.2745),
                            "Remembrance": Color(red: 0.2745, green: 0.6745, blue: 0.9569),
                            "Erudition": Color(red: 0.6157, green: 0.2235, blue: 0.8275),
                            "The Hunt": Color(red: 0.2588, green: 0.8196, blue: 0.549),
                            "Nihility": Color(red: 0.2549, green: 0.2431, blue: 0.6275),
                            "Abundance": Color(red: 0.9373, green: 0.8196, blue: 0.298),
                            "Preservation": Color(red: 0.8588, green: 0.4392, blue: 0.3765),
                            "Harmony": Color(red: 0.5333, green: 0.4157, blue: 0.7882)
                        ])
                        .frame(height: 300)
                        .padding()
                        .background(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.85, green: 0.75, blue: 0.55).opacity(0.4), lineWidth: 1)
                        )
                        
                    }
                    .padding()
                }
            }
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .task {
            do {
                let service = StarRailService()
                self.characters = try await service.fetchCharacter()
                self.light_cones = try await service.fetchLightCone()
                self.isLoading = false
            } catch {
                print("Failed to load data: \(error)")
                self.isLoading = false
            }
        }
    }
}


#Preview {
    AnalyticsView()
}
