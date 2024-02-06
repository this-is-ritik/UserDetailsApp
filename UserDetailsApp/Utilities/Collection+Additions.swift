//
//  Collection+Additions.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 07/02/24.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
