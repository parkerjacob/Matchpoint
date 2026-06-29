//
//  MainTabView.swift
//  Matchpoint
//
//  Created by Jacob Parker on 25/6/2026.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var user : MatchpointViewModel
    @StateObject private var matches = MatchViewModel()
    var body: some View {
        TabView {
            FavoritesView()
                .environmentObject(matches)
                .tabItem {
                    Label("Favorites", image: "star")
                }
            
            MatchesView()
                .environmentObject(matches)
                .tabItem {
                    Label("Matches", image: "home")
                }
            
            ProfileView()
                .environmentObject(matches)
                .tabItem {
                    Label("Profile", image: "profile")
                }
        }.task {
            await matches.fetchMatches()
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(MatchpointViewModel())
}
