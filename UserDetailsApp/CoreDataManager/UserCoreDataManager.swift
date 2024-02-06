//
//  CoreDataManager.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 06/02/24.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func success()
    func failure()
}

extension CoreDataManagerProtocol {
    func success() {
        
    }
    
    func failure() {
        
    }
}

@MainActor
class UserCoreDataManager {
        
    private let delegate: CoreDataManagerProtocol?
    
    static var sharedInstance = UserCoreDataManager(delegate: nil)
    
    private var persistentContainer: NSPersistentContainer
    
    init(delegate: CoreDataManagerProtocol?) {
        self.delegate = delegate
        self.persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    func insert(users: [UserData.User]?) {
        guard let users = users?.compactMap( { $0 }) else { return }
        for user in users {
            self.insertUser(user: user)
        }
    }
    
    private func insertUser(user: UserData.User) {
        let entity = User(context: self.persistentContainer.viewContext)
        entity.avatar = user.avatar
        entity.email = user.email
        entity.first_name = user.firstName
        entity.last_name = user.lastName
        entity.setValue(user.id, forKey: "id")
        self.saveContext()
    }
    
    // save context
    func saveContext() {
        guard self.persistentContainer.viewContext.hasChanges == true else { return }
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            print("\(error)")
        }
    }
    
    func loadUsers() -> [User]? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try self.persistentContainer.viewContext.fetch(request)
            return users
        } catch {
            print("error fetching user data from core data model")
            print(error)
        }
        return nil
    }
}
