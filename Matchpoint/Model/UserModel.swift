//
//  UserModel.swift
//  Matchpoint
//
//  Created by Jacob Parker on 25/6/2026.
//

import Foundation
import FirebaseFirestore

struct UserModel: Codable, Identifiable {
    @DocumentID var id: String?
    var username: String
    var email: String
}
