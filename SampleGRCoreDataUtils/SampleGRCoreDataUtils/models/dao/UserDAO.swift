//
//  UserDAO.swift
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Revilo on 17/08/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

import UIKit
import CoreData

class UserDAO: GRCoreDataUtils {
    static func deleteUser(user:User){
        deleteManagedObject(user);
        saveDatabase()
    }
    static func userUpdatedWithDictionary(dictionary:Dictionary<String,AnyObject>) -> User{
        let managedObjectKeyPathsArray:[String] = ["firstname", "lastname", "userId"];
        let dictionaryKeyPathsArray:[String] = managedObjectKeyPathsArray;
        return userUpdatedWithKeyPaths(keyPathsArray: managedObjectKeyPathsArray, withDictionary: dictionary, dictionaryKeyPaths: dictionaryKeyPathsArray);

    }
    
    static func userUpdatedWithKeyPaths(#keyPathsArray:[String], withDictionary dictionary:Dictionary<String,AnyObject>, dictionaryKeyPaths: [String]) -> User{
        
        return managedObject(entityClass: User.self,
                         predicateFormat: String(format: "userId='%@'", dictionary["userId"] as! String),
                   managedObjectKeyPaths: keyPathsArray,
                    updateWithDictionary: dictionary,
                      dictionaryKeyPaths: dictionaryKeyPaths) as! User
    }
    
    static func fetchedResultsControllerWithDelegate(#delegate:NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController?{
        return fetchedResultsController(entityClass: User.self,
                                           delegate: delegate,
                                    sortDescriptors: [
                                                        NSSortDescriptor(key: "firstname", ascending: true),
                                                        NSSortDescriptor(key: "lastname", ascending: true)
                                                    ] as [NSSortDescriptor],
                                 sectionNameKeyPath: nil);
    }
    

}
