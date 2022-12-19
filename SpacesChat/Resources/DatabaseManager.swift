//
//  DatabaseManager.swift
//  SpacesChat
//
//  Created by Darren Borromeo on 16/12/2022.
//

import Foundation
import FirebaseDatabase


class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
}

// MARK: - Account Management

extension DatabaseManager {
    
    /// Checks is a user already exists via the given email.
    ///     - @param completion: returns true if the users email exists, false if it doesn't.
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        // Get safeEmail - database doesn't allow "." and "@".
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail     = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        // Check for safeEmail.
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            // If the value is a string, check to see if it's nil.
            guard snapshot.value as? String != nil else {
                completion(false)  // Email doesn't exist - create account.
                return
            }
            completion(true)       // Found email - don't create account.
        })
    }
    
    /// Add a user into the firebase database.
    /// A user is a child of the database. A child's (key) is an email, with (values) user information in a dictionary.
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            // We don't include the email address because it's the key.
            // No 2 users can have the same user address, so it's valid.
            "first_name": user.firstName,
            "last_name":  user.lastName,
        ])
    }
}

struct ChatAppUser {
    let firstName:         String
    let lastName:          String
    let emailAddress:      String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail     = safeEmail.replacingOccurrences(of: "@", with: "-")
        return          safeEmail
    }
    
//    let profilePictureUrl: String
}
