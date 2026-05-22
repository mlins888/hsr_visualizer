//
//  ContentView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/20/26.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                
                // BACKGROUND CIRCLES
                DecorativeCircle()
                    .offset(x: 16, y: -120)
                DecorativeCircle()
                    .offset(x: -20, y: -100)
                
                DecorativeCircle()
                    .offset(x: -240, y: -500)
                DecorativeCircle()
                    .offset(x: -180, y: -540)
                
                DecorativeCircle()
                    .offset(x: 230, y: 450)
                DecorativeCircle()
                    .offset(x: 200, y: 550)
                
                //MAIN TEXT AREA
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    //TITLE TEXT
                    Text("Star Rail")
                        .font(Font.custom("Spirax-Regular", size: 70))
                        .foregroundStyle(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.83, green: 0.69, blue: 0.42), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.35, green: 0.27, blue: 0.24), location: 1.00),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                                )
                        )
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                    Text("Data Bank")
                        .font(Font.custom("MuseoModerno-Light", size: 35))
                        .foregroundColor(Color(red: 0.97, green: 0.93, blue: 0.7))
                    
                    //MENU BUTTON TEXT
                    NavigationLink(destination: CharacterView()) {
                        Text("Characters")
                            .font(Font.custom("NixieOne-Regular", size: 24))
                            .foregroundColor(Color(red: 0.85, green: 0.75, blue: 0.55))
                            .frame(width: 277, height: 60)
                            .background(.ultraThinMaterial)
                            .environment(\.colorScheme, .dark)
                            .cornerRadius(26)
                            .overlay(
                                RoundedRectangle(cornerRadius: 26)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.75, green: 0.59, blue: 0.3), lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                    }
                    .buttonStyle(.plain)
                    NavigationLink(destination: LightConeView()) {
                        Text("Light Cones")
                            .font(Font.custom("NixieOne-Regular", size: 24))
                            .foregroundColor(Color(red: 0.85, green: 0.75, blue: 0.55))
                            .frame(width: 277, height: 60)
                            .background(.ultraThinMaterial)
                            .environment(\.colorScheme, .dark)
                            .cornerRadius(26)
                            .overlay(
                                RoundedRectangle(cornerRadius: 26)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.75, green: 0.59, blue: 0.3), lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                    }
                    .buttonStyle(.plain)
                    NavigationLink(destination: RelicView()) {
                        Text("Relics")
                            .font(Font.custom("NixieOne-Regular", size: 24))
                            .foregroundColor(Color(red: 0.85, green: 0.75, blue: 0.55))
                            .frame(width: 277, height: 60)
                            .background(.ultraThinMaterial)
                            .environment(\.colorScheme, .dark)
                            .cornerRadius(26)
                            .overlay(
                                RoundedRectangle(cornerRadius: 26)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.75, green: 0.59, blue: 0.3), lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                    }
                    .buttonStyle(.plain)
                    NavigationLink(destination: SimUniverseView()) {
                        Text("Sim Universe")
                            .font(Font.custom("NixieOne-Regular", size: 24))
                            .foregroundColor(Color(red: 0.85, green: 0.75, blue: 0.55))
                            .frame(width: 277, height: 60)
                            .background(.ultraThinMaterial)
                            .environment(\.colorScheme, .dark)
                            .cornerRadius(26)
                            .overlay(
                                RoundedRectangle(cornerRadius: 26)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.75, green: 0.59, blue: 0.3), lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Spacer()
                }
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
}



#Preview {
    ContentView()
}
