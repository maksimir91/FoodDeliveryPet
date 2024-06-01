//
//  UserStorage.swift
//  FoodDeliveryPet
//
//  Created by Stanislav Shut on 31.05.2024.
//

import Foundation

class UserStorage {
    
    static let shared = UserStorage()
    
    var passedOnboarding: Bool {
        get { UserDefaults.standard.bool(forKey: "passedOnboarding") }
        set { UserDefaults.standard.set(newValue, forKey: "passedOnboarding") }
    }
    
}
