//
//  ProfileView.swift
//  Matchpoint
//
//  Created by Jacob Parker on 25/6/2026.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user : MatchpointViewModel
    @EnvironmentObject var matches : MatchViewModel
    
    var body: some View {
        VStack (alignment: .center, spacing: 20) {
            Image("user")
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
            
            Text(user.username)
            Text(user.email)
            
            NavigationLink {
                EditFavoritesView()
                    .environmentObject(matches)
            } label: {
                HStack {
                    Text("Edit Favorite Teams")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: 200)
            }
            Button("Logout") {
                user.logout()
            }
        }
    }
}

#Preview {
    ProfileView()
}
