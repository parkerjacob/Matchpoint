//
//  Match.swift
//  Matchpoint
//
//  Created by Jacob Parker on 25/6/2026.
//

import Foundation

struct MatchModel: Codable, Identifiable {
    let id: Int
    let name: String
    let beginAt: String
    let status: String
    let numberOfGames: Int
    
    let league: League
    let tournament: Tournament
    let serie: Serie
    let results: [Result]
    let opponents: [Opponent]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case beginAt = "begin_at"
        case status
        case numberOfGames = "number_of_games"
        
        case league
        case tournament
        case serie
        case results
        case opponents
    }
    
    func formattedDate() -> String {

        let input = ISO8601DateFormatter()

        guard let date = input.date(from: beginAt) else {
            return beginAt
        }

        let output = DateFormatter()
        output.dateFormat = "MMMM d  h:mm a"

        return output.string(from: date)
    }
}

struct League: Codable {
    let name: String
}

struct Tournament: Codable {
    let name: String
}

struct Result: Codable {
    let teamID: Int
    let score: Int
    
    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case score
    }
}

struct Serie: Codable {
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}

struct Opponent: Codable {
    let opponent: Team
}

struct Team: Codable, Identifiable {
    let id: Int
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
    }
}
