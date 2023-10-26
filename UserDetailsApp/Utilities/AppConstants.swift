//
//  AppConstants.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 26/10/23.
//

import Foundation

enum AppConstants {
    
    enum URL: String {
        case homeApiUrl = "https://reqres.in/api/users?page=2"
        
        var value: String {
            return self.rawValue
        }
    }
    enum UserDefaultsPath: String {
        case homeApiData = "HomeApiData"
        
        var value: String {
            return self.rawValue
        }
    }
}
