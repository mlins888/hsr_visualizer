//
//  ContentView.swift
//  game_visualizer_individual
//
//  Created by Makenna Linsky on 5/20/26.
//


import SwiftUI

struct ContentView: View {
    
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground() // Keeps your space background visible
            
            // 2. Define your custom Gold color and Font using UIKit equivalents (UIColor / UIFont)
            let goldColor = UIColor(red: 0.85, green: 0.75, blue: 0.55, alpha: 1.0)
            // If you registered Spirax or DIN, use it here! Fallback is system font.
            let customFont = UIFont(name: "NixieOne-Regular", size: 34) ?? .systemFont(ofSize: 34, weight: .bold)
            let smallCustomFont = UIFont(name: "MuseoModerno-Light", size: 20) ?? .systemFont(ofSize: 20, weight: .semibold)
            
            // 3. Apply the styles to both the Large title (when scrolled up) and Inline title (when scrolled down)
            appearance.largeTitleTextAttributes = [
                .foregroundColor: goldColor,
                .font: customFont
            ]
            
            appearance.titleTextAttributes = [
                .foregroundColor: goldColor,
                .font: smallCustomFont
            ]
            
            // 4. Force the navigation bar to use these rules
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()
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
                    NavigationLink(destination: RelicSetView()) {
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
                    NavigationLink(destination: AnalyticsView()) {
                        Text("Analytics")
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
        }
    }
}



#Preview {
    ContentView()
}
