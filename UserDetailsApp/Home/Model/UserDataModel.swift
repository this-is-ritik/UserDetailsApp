//
//  UserDataModel.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 26/10/23.
//

import Foundation

struct UserData: Codable {
    let page: Int?
    let perPage: Int?
    let total: Int?
    let totalPages: Int?
    var data: [User]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
        case support
    }
    struct User: Codable {
        let id: Int64?
        let email: String?
        let firstName: String?
        let lastName: String?
        let avatar: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case email
            case firstName = "first_name"
            case lastName = "last_name"
            case avatar
        }
    }

    struct Support: Codable {
        let url: String?
        let text: String?
    }
}
