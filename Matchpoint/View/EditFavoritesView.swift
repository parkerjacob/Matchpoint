//
//  EditFavoritesView.swift
//  Matchpoint
//
//  Created by Jacob Parker on 26/6/2026.
//

import SwiftUI

struct EditFavoritesView: View {
    @EnvironmentObject var user : MatchpointViewModel
    @EnvironmentObject var matches : MatchViewModel
    
    var body: some View {
        List {
            ForEach(matches.teams, id: \.id) { team in
                HStack {
                    Button {
                        user.toggleFavorites(teamID: team.id)
                    } label: {
                        Image(systemName: user.favoriteTeamIDs.contains(team.id) ? "star.fill" : "star")
                            .foregroundColor(user.favoriteTeamIDs.contains(team.id) ? .yellow : .gray)
                    }.buttonStyle(.borderless)
                    
                    Image("\(team.id)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    Text(team.name)
                }
            }
        }
    }
}

#Preview {
    EditFavoritesView()
}
