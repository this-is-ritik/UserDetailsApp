//
//  CacheManager.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 26/10/23.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()

    private init() {}

    func saveData(_ data: Data, forKey key: String) {
        UserDefaults.standard.setValue(data, forKey: key)
    }

    func loadData(forKey key: String) -> Data? {
        let data = UserDefaults.standard.value(forKey: key) as? Data
        guard let data else {
            return nil
        }
        return data
    }
}
