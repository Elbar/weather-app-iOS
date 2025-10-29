//
//  UserDefaultsManager.swift
//  weatherapp
//
//  Created by Elbar on 27/10/25.
//


import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() {}
    
    private let lastCityKey = "lastCity"
    
    func saveLastCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: lastCityKey)
    }
    
    func getLastCity() -> String {
        return UserDefaults.standard.string(forKey: lastCityKey) ?? "Moscow"
    }
}
