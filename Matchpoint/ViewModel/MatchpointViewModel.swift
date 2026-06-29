//
//  MatchpointViewModel.swift
//  Matchpoint
//
//  Created by Jacob Parker on 25/6/2026.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class MatchpointViewModel : ObservableObject {
    @Published var isLoggedIn = false
    @Published var errorMessage = ""
    @Published var showError = false
    
    @Published var username = ""
    @Published var email = ""
    @Published var favoriteTeamIDs: [Int] = []
    
    init() {
        isLoggedIn = Auth.auth().currentUser != nil
        loadUser()
        loadFavorites()
    }
    
    func signup(email: String, username: String, password: String) {
        print("pressed signup")
        Auth.auth().createUser(withEmail: email,
                               password: password) { result, error in
            
            guard let user = result?.user else { return }
            let uid = user.uid
            Firestore.firestore()
                .collection("users")
                .document(uid)
                .setData([
                    "email": email,
                    "username": username,
                    "createdAt": Timestamp()
                ]) { error in
                    
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        print("Firestore Error:", error.localizedDescription)
                        self.showError = true
                        return
                    }
                }
            print("Firestore write successful")
            self.isLoggedIn = true
        }
    }
    
    func login(email: String, password: String) {
        print("pressed login")
        Auth.auth().signIn(withEmail: email,
                           password: password) { result, error in
            
            if let error = error {
                print(error.localizedDescription)
                self.showError = true
                self.errorMessage = error.localizedDescription
                return
            }
            
            self.isLoggedIn = true
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.showError = true
        }
    }
    
    func loadUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        self.email = Auth.auth().currentUser?.email ?? ""
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument { document, error in
                guard let data = document?.data() else {
                    return
                }
                
                self.username = data["username"] as? String ?? ""
                self.favoriteTeamIDs = data["favoriteTeamIDs"] as? [Int] ?? []
            }
    }
    
    func saveFavorites() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .updateData(["favoriteTeamIDs": self.favoriteTeamIDs])
    }
    
    func loadFavorites() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument { document, error in
                guard let data = document?.data() else {
                    return
                }
                
                self.favoriteTeamIDs = data["favoriteTeamIDs"] as? [Int] ?? []
            }
    }
    
    func toggleFavorites(teamID: Int) {
        if favoriteTeamIDs.contains(teamID) {
            favoriteTeamIDs.removeAll { $0 == teamID }
        } else {
            favoriteTeamIDs.append(teamID)
        }
        
        saveFavorites()
        
    }
}
