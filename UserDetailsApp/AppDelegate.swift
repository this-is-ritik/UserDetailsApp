//
//  AppDelegate.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 26/10/23.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserCoreData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error else {return}
            fatalError("Unresolved error \(error)")
        })
        return container
    }()


    func applicationWillTerminate(_ application: UIApplication) {
        UserCoreDataManager.sharedInstance.saveContext()
    }
}

