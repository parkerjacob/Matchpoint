//
//  ContentView.swift
//  Matchpoint
//
//  Created by Jacob Parker on 25/6/2026.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user: MatchpointViewModel
    
    var body: some View {
        if user.isLoggedIn {
            NavigationStack {
                MainTabView()
            }
        } else {
            NavigationStack {
                LoginView()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(MatchpointViewModel())
}
