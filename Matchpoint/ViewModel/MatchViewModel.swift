//
//  MatchViewModel'.swift
//  Matchpoint
//
//  Created by Jacob Parker on 25/6/2026.
//

import Foundation
import Combine

class MatchViewModel : ObservableObject {
    private let apiKey = "YOUR KEY HERE"
    
    @Published var matches: [MatchModel] = []
    @Published var teams: [Team] = []
    @Published var isLoading: Bool = false
    @Published var hasError = false
    @Published var pandaScoreError: PandaScoreError?

    @MainActor
    func fetchMatches() async {
        print("Fetch matches called")
        isLoading = true
        matches.removeAll()
        
        let baseURL = URL(string: "https://api.pandascore.co/codmw/matches")!
        
        var request = URLRequest(url: baseURL)
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "authorization")

        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
            let response = try JSONDecoder().decode([MatchModel].self, from: data)
            self.matches = response
            self.matches = self.matches.sorted(by: { $0.beginAt < $1.beginAt })
            self.teams = getTeams(matches: self.matches)
            self.isLoading = false
        } catch {
            self.hasError = true
            self.pandaScoreError = .customError(error: error)
            self.isLoading = false
        }
    }
    
    func getTeams(matches: [MatchModel]) -> [Team] {
        for match in matches {
            for opponent in match.opponents {
                if !teams.contains(where: { $0.id == opponent.opponent.id }) {
                    teams.append(opponent.opponent)
                }
            }
        }
        
        return teams
    }
    
    enum PandaScoreError: LocalizedError {
        case decodingError
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
                case .decodingError:
                return "Failed to decode PandaScore response"
            case .customError(error: let error):
                return error.localizedDescription
            }
        }
    }
}
