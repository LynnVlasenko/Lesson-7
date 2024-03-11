//
//  UserProfile+UserType.swift
//  Lesson-7_Project
//
//  Created by Алина Власенко on 11.03.2024.
//

import Foundation

extension UserProfile {
    enum UserType {
        case admin
        case regular
        case superAdmin
    }
    
    // додаємо певні права для типів юзерів
    func availableServices() -> [String] {
        switch self.type {case .admin:
            return ["1","3"]
        case .regular:
            return []
        case .superAdmin:
            return ["1", "2", "3"]
        }
        
    }
}
