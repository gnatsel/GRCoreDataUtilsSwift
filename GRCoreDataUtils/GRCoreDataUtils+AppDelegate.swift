//
//  GRCoreDataUtils+AppDelegate.swift
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Revilo on 17/08/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

import UIKit
import CoreData

extension GRCoreDataUtils{
    
    /**
    * @return AppDelegate
    */
    
    static func appDelegate() -> AppDelegate{
        return UIApplication.sharedApplication().delegate as! AppDelegate;
    }
    
    /**
    * @return managedObjectContext from AppDelegate
    */
    
    static func managedObjectContext() -> NSManagedObjectContext?{
        return appDelegate().managedObjectContext;
    }
    
    
    /**
    * Fetch or create an NSManagedObject corresponding to the entity name. This method handles errors if the key paths or the keys in the given dictionary are not found
    *
    * @param entityName                    The name of the entity to fetch
    * @param predicateFormat               The predicate to fulfill
    * @param managedObjectKeyPathsArray    The array of keypaths to update in the NSManagedObject
    * @param dictionary                    The dictionary that will update the NSManagedObject before returning it
    * @param dictionaryKeyPathsArray       The array of keypaths to find in the dictionary
    *
    * @note    managedObjectKeyPathsArray and dictionaryKeyPathsArray should have the same size
    *          each keypath of the NSManagedObject in managedObjectKeyPathsArray will be updated with the same index of the value from dictionaryKeyPathsArray
    *          the NSManagedObjectContext used is provided by AppDelegate
    *
    * @return an instantiated NSManagedObject updated with the given dictionary
    */
    static func managedObject(#entityName:String,
                          predicateFormat:String?,
                    managedObjectKeyPaths:[String]?,
          updateWithDictionary dictionary:Dictionary<String,AnyObject>?,
                       dictionaryKeyPaths:[String]?) -> NSManagedObject?{
        return managedObject(entityName:entityName,
                        predicateFormat:predicateFormat,
                  managedObjectKeyPaths:managedObjectKeyPaths,
                   updateWithDictionary:dictionary,
                     dictionaryKeyPaths:dictionaryKeyPaths,
                   managedObjectContext:managedObjectContext()!)
    }
    
    
    
    /**
    * Fetch or create an NSManagedObject corresponding to the entity class. This method handles errors if the key paths or the keys in the given dictionary are not found
    *
    * @param entityClass                   The class of the entity to fetch
    * @param predicateFormat               The predicate to fulfill
    * @param managedObjectKeyPathsArray    The array of keypaths to update in the NSManagedObject
    * @param dictionary                    The dictionary that will update the NSManagedObject before returning it
    * @param dictionaryKeyPathsArray       The array of keypaths to find in the dictionary
    *
    * @note    managedObjectKeyPathsArray and dictionaryKeyPathsArray should have the same size
    *          each keypath of the NSManagedObject in managedObjectKeyPathsArray will be updated with the same index of the value from dictionaryKeyPathsArray
    *          the NSManagedObjectContext used is provided by AppDelegate
    *
    * @return an instantiated NSManagedObject updated with the given dictionary
    */
    static func managedObject(#entityClass:AnyClass,
                           predicateFormat:String?,
                     managedObjectKeyPaths:[String]?,
           updateWithDictionary dictionary:Dictionary<String,AnyObject>?,
                        dictionaryKeyPaths:[String]?) -> NSManagedObject? {
            return managedObject(entityClass:entityClass,
                             predicateFormat:predicateFormat,
                       managedObjectKeyPaths:managedObjectKeyPaths,
                        updateWithDictionary:dictionary,
                          dictionaryKeyPaths:dictionaryKeyPaths,
                        managedObjectContext:managedObjectContext()!)
    }
    
    
    /**
    * Fetch NSManagedObjects for the given entity class
    *
    * @param entityClass   The class of the entity to fetch
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    *
    * @return an NSArray of NSManagedObjects for the given entity class
    */
    static func managedObjectsArray(forEntityClass entityClass:AnyClass) -> [AnyObject]? {
        return GRCoreDataUtils.managedObjectsArray(forEntityClass: entityClass, withPredicateFormat: nil);
    }
    
    /**
    * Fetch NSManagedObjects for the given entity class and predicate
    *
    * @param entityClass       The class of the entity to fetch
    * @param predicateFormat   The predicate of the fetch request
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    *
    * @return an NSArray of NSManagedObjects for the given entity class
    */
    static func managedObjectsArray(forEntityClass entityClass:AnyClass,
                           withPredicateFormat predicateFormat:String?) -> [AnyObject]? {
        return GRCoreDataUtils.managedObjectsArray(forEntityClass: entityClass, withPredicateFormat: predicateFormat, inManagedObjectContext: managedObjectContext()!);
    }
    /**
    * Fetch NSManagedObjects for the given entity name
    *
    * @param entityName   The name of the entity to fetch
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    *
    * @return an NSArray of NSManagedObjects for the given entity name
    */
    static func managedObjectsArray(forEntityName entityName:String) -> [AnyObject]?{
        return GRCoreDataUtils.managedObjectsArray(forEntityName: entityName, withPredicateFormat: nil);
    }
    
    /**
    * Fetch NSManagedObjects for the given entity class and predicate
    *
    * @param entityName       The name of the entity to fetch
    * @param predicateFormat   The predicate of the fetch request
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    *
    * @return an NSArray of NSManagedObjects for the given entity name
    */
    static func managedObjectsArray(forEntityName entityName:String,
                         withPredicateFormat predicateFormat:String?) -> [AnyObject]?{
        return GRCoreDataUtils.managedObjectsArray(forEntityName: entityName, withPredicateFormat: predicateFormat, inManagedObjectContext: managedObjectContext()!);
    }
    
    /**
    * Delete the given managed object
    *
    * @param managedObject   The NSManagedObject to delete
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    */
    static func deleteManagedObject(managedObject:NSManagedObject){
        managedObjectContext()!.deleteObject(managedObject);
    }
    
    /**
    * Delete all NSManagedObjects not existing in managedObjectsArray for the given entity class and corresponding to the given predicate
    *
    * @param managedObjectArray    The NSArray of NSManagedObjects to preserve
    * @param entityClass           The name of the entity to fetch
    * @param predicateFormat       The predicate used to delete NSManagedObjects
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    */
    
    static func deleteManagedObjectsNotInArray(#managedObjectsArray:[AnyObject],
        entityClass:AnyClass,
        predicateFormat:String?) {
            deleteManagedObjectsNotInArray(managedObjectsArray: managedObjectsArray, entityClass: entityClass, predicateFormat: predicateFormat,  inManagedObjectContext: managedObjectContext()!);
    }
    /**
    * Delete all NSManagedObjects not existing in managedObjectsArray for the given entity class and corresponding to the given predicate
    *
    * @param managedObjectArray    The NSArray of NSManagedObjects to preserve
    * @param entityName           The name of the entity to fetch
    * @param predicateFormat       The predicate used to delete NSManagedObjects
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    */
    static func deleteManagedObjectsNotInArray(#managedObjectsArray:[AnyObject],
        entityName:String,
        predicateFormat:String?) {
            deleteManagedObjectsNotInArray(managedObjectsArray: managedObjectsArray, entityName: entityName, predicateFormat: predicateFormat,  inManagedObjectContext: managedObjectContext()!);
    }
    
    /**
    * Delete all NSManagedObjects not existing in managedObjectsArray for the given entity class
    *
    * @param managedObjectArray    The NSArray of NSManagedObjects to preserve
    * @param entityClass           The class of the entity to fetch
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    */
    static func deleteManagedObjectsNotInArray(#managedObjectArray:[AnyObject],
                                                       entityClass:AnyClass) {
        deleteManagedObjectsNotInArray(managedObjectsArray: managedObjectArray, entityClass: entityClass, predicateFormat: nil);
    }
    
    /**
    * Delete all NSManagedObjects not existing in managedObjectsArray for the given entity name
    *
    * @param managedObjectArray    The NSArray of NSManagedObjects to preserve
    * @param entityName            The name of the entity to fetch
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    */
    static func deleteManagedObjectsNotInArray(#managedObjectArray:[AnyObject],
                                                        entityName:String) {
        deleteManagedObjectsNotInArray(managedObjectsArray: managedObjectArray, entityName: entityName, predicateFormat: nil);
    }
    

    
    /**
    * Delete all NSManagedObjects for the given entity class
    *
    * @param entityClass           The name of the entity to fetch
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    */
    static func deleteManagedObjectsForEntityClass(#entityClass:AnyClass){
        deleteManagedObjects(entityClass: entityClass, inManagedObjectContext: managedObjectContext()!)
    }
    
    /**
    * Delete all NSManagedObjects for the given entity name
    *
    * @param entityName           The name of the entity to fetch
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    */
    static func deleteManagedObjectsForEntityName(#entityName:String){
        deleteManagedObjects(entityName: entityName, inManagedObjectContext: managedObjectContext()!);
    }
    
    /**
    * Set a keyPath value for all NSManagedObjects corresponding to the given entity class not existing in managedObjectArray
    *
    * @param value           The value that will be set for the given keyPath
    * @param keyPath         The keyPath in the NSManagedObjects to update
    * @param entityClass     The class of the entity to fetch
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    */
    static func setValue(       #value:AnyObject,
                    forKeyPath keyPath:String,
            forEntityClass entityClass:AnyClass,
        notInArray managedObjectsArray:[AnyObject]){
            
        setValue(value: value, forKeyPath: keyPath, forEntityName: NSStringFromClass(entityClass), notInArray: managedObjectsArray);
    }
    
    /**
    * Set a keyPath value for all NSManagedObjects corresponding to the given entity class not existing in managedObjectArray
    *
    * @param value           The value that will be set for the given keyPath
    * @param keyPath         The keyPath in the NSManagedObjects to update
    * @param entityName           The name of the entity to fetch
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    */
    static func setValue(       #value:AnyObject,
                    forKeyPath keyPath:String,
              forEntityName entityName:String,
        notInArray managedObjectsArray:[AnyObject]){
            
        if let allManagedObjectsArray:[AnyObject] = GRCoreDataUtils.managedObjectsArray(forEntityName: entityName){
            for managedObject:NSManagedObject in allManagedObjectsArray as! [NSManagedObject]{
                if !(managedObjectsArray as NSArray).containsObject(managedObject){
                    managedObject.setValue(value, forKeyPath: keyPath)
                }
            }
        }
    }
    
    
    /**
    * Save the context from AppDelegate
    */
    //+(void)saveDatabase;
    static func saveDatabase(){
        appDelegate().saveContext();
    }
    
    /**
    * Instantiate and return an NSFetchedResultsController for an entity with the given class
    *
    * @param entityClass       The class of the entity to fetch
    * @param delegate          The delegate of the NSFetchedResultsController
    * @param sortDescriptors   The sort descriptors used by the NSFetchedRequest instance of the NSFetchedResultsController
    * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    *
    * @return an instantiated NSFetchedResultsController
    */
    static func fetchedResultsController(#entityClass:AnyClass,
                                             delegate:NSFetchedResultsControllerDelegate?,
                                      predicateFormat:String?,
                                      sortDescriptors:[NSSortDescriptor],
                                   sectionNameKeyPath:String?) -> NSFetchedResultsController{
                                    
            return fetchedResultsController(entityClass:entityClass,
                                               delegate:delegate,
                                        predicateFormat:predicateFormat,
                                        sortDescriptors:sortDescriptors,
                                     sectionNameKeyPath:sectionNameKeyPath,
                                   managedObjectContext:managedObjectContext()!)
    }
    
    /**
    * Instantiate and return an NSFetchedResultsController for an entity with the given name
    *
    * @param entityClass       The class of the entity to fetch
    * @param delegate          The delegate of the NSFetchedResultsController
    * @param sortDescriptors   The sort descriptors used by the NSFetchedRequest instance of the NSFetchedResultsController
    * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    *
    * @return an instantiated NSFetchedResultsController
    */
    static func fetchedResultsController(#entityClass:AnyClass,
                                             delegate:NSFetchedResultsControllerDelegate?,
                                      sortDescriptors:[NSSortDescriptor],
                                   sectionNameKeyPath:String?) -> NSFetchedResultsController{
            
            return fetchedResultsController(entityClass:entityClass,
                                               delegate:delegate,
                                        predicateFormat:nil,
                                        sortDescriptors:sortDescriptors,
                                     sectionNameKeyPath:sectionNameKeyPath)
    }
    
    /**
    * Instantiate and return an NSFetchedResultsController for an entity with the given class
    *
    * @param entityName            The name of the entity to fetch
    * @param delegate              The delegate of the NSFetchedResultsController
    * @param predicateFormat       The predicate format to fulfill
    * @param sortDescriptors       The array of descriptors for the NSFetchedResultsController
    * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    *
    * @return an NSFetchedResultsController for the given managedObjectContext
    */
    static func fetchedResultsController(#entityName:String,
                                            delegate:NSFetchedResultsControllerDelegate?,
                                     predicateFormat:String?,
                                     sortDescriptors:[NSSortDescriptor],
                                  sectionNameKeyPath:String?) -> NSFetchedResultsController{
            
            return fetchedResultsController(entityName:entityName,
                                              delegate:delegate,
                                       predicateFormat:predicateFormat,
                                       sortDescriptors:sortDescriptors,
                                    sectionNameKeyPath:sectionNameKeyPath,
                                  managedObjectContext:managedObjectContext()!)
    }
    
    /**
    * Instantiate and return an NSFetchedResultsController for an entity with the given name
    *
    * @param entityName            The name of the entity to fetch
    * @param delegate              The delegate of the NSFetchedResultsController
    * @param sortDescriptors       The array of descriptors for the NSFetchedResultsController
    * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
    *
    * @note    the NSManagedObjectContext used is provided by AppDelegate
    *
    * @return an NSFetchedResultsController for the given managedObjectContext
    */
    static func fetchedResultsController(#entityName:String,
                                            delegate:NSFetchedResultsControllerDelegate?,
                                     sortDescriptors:[NSSortDescriptor],
                                  sectionNameKeyPath:String) -> NSFetchedResultsController{
            
            return fetchedResultsController(entityName:entityName,
                                              delegate:delegate,
                                       predicateFormat:nil,
                                       sortDescriptors:sortDescriptors,
                                    sectionNameKeyPath:sectionNameKeyPath)
    }

}
