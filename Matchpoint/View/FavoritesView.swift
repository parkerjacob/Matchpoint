//
//  FavoritesView.swift
//  Matchpoint
//
//  Created by Jacob Parker on 25/6/2026.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var user : MatchpointViewModel
    @EnvironmentObject var matches : MatchViewModel
    
    @State private var selected = "Upcoming"
    let options = ["Upcoming", "Completed"]
    
    var body: some View {
        if user.favoriteTeamIDs.isEmpty {
            VStack {
                Image("star")
                    .frame(width: 50, height: 50)
                Text("No Favorites")
                Text("Go to Profile and edit your favorites")
                    .foregroundStyle(.secondary)
                
            }
        } else {
            ScrollView {
                Picker("Selection", selection: $selected) {
                    ForEach (options, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding(15)
                
                if selected == "Upcoming" {
                    ForEach(matches.matches) { match in
                        if match.status == "not_started" && match.opponents.count >= 2 && match.opponents.contains(where: { opponent in
                            user.favoriteTeamIDs.contains(opponent.opponent.id)
                        }) {
                            VStack (alignment: .leading) {
                                Text(match.name)
                                    .font(.headline)
                                Divider()
                                HStack {
                                    VStack {
                                        Image("\(match.opponents[0].opponent.id)")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        Text(match.opponents[0].opponent.name)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    VStack (alignment: .center){
                                        Text("vs")
                                        Text("Best of \(match.numberOfGames)")
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    VStack {
                                        Image("\(match.opponents[1].opponent.id)")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        Text(match.opponents[1].opponent.name)
                                            .multilineTextAlignment(.trailing)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                VStack (alignment: .center){
                                    Text(match.formattedDate())
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding(15)
                        }
                    }
                }
                
                if selected == "Completed" {
                    ForEach (matches.matches) { match in
                        if match.status == "finished" && match.opponents.count >= 2 && match.opponents.contains(where: { opponent in
                            user.favoriteTeamIDs.contains(opponent.opponent.id)
                        }) {
                            VStack (alignment: .leading) {
                                Text(match.serie.fullName)
                                    .font(.headline)
                                Divider()
                                HStack {
                                    VStack {
                                        Image("\(match.opponents[0].opponent.id)")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        Text(match.opponents[0].opponent.name)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    VStack (alignment: .center){
                                        if match.results.count >= 2 {
                                            Text("\(match.results[0].score) : \(match.results[1].score)")
                                                .font(.headline)
                                        }
                                        Text("Best of \(match.numberOfGames)")
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    VStack {
                                        Image("\(match.opponents[1].opponent.id)")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        Text(match.opponents[1].opponent.name)
                                            .multilineTextAlignment(.trailing)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .padding(15)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
}
