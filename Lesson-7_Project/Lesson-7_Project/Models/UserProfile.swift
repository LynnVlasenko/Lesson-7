//
//  UserProfile.swift
//  Lesson-7_Project
//
//  Created by Алина Власенко on 11.03.2024.
//

import Foundation

struct UserProfile {
    
    var id = UUID().uuidString
    var firstName = "Peter"
    var lastName = "Fisher"
    var type: UserType = .admin
    
    var themeColor = "hexColor" // не зможимо опрацювати
    var favorites: [String] = []
}

// Extensions - не підтримують додавання нових властивостей через розширення
// private extensions
// private - модифікатор доступу
