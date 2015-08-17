//
//  GRCoreDataUtils.swift
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Revilo on 14/08/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

import UIKit
import CoreData

class GRCoreDataUtils: NSObject {
    /**
    * Fetch or Create an NSManagedObject fulfilling the given predicate
    *
    * @param entityName            The name of the entity to fetch
    * @param predicateFormat       The predicate to fulfill
    * @param managedObjectContext  The NSManagedObjectContext where the fetch is performed
    *
    * @return an NSManagedObject fulfilling the given predicate
    */
    
    static func managedObject(  #entityName:String,
                            predicateFormat:String?,
                       managedObjectContext:NSManagedObjectContext) -> NSManagedObject?{
            var managedObject:NSManagedObject?
            var shouldInstantiateNewManagedObject = true
            if let entityDescription:NSEntityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedObjectContext) {
                if predicateFormat != nil {
                    let request:NSFetchRequest = NSFetchRequest()
                    request.entity = entityDescription
                    request.predicate = NSPredicate(format: predicateFormat!, argumentArray:nil)
                    var error:NSError? = nil;
                    var managedObjectsArray:Array<NSManagedObject>? = managedObjectContext.executeFetchRequest(request, error: &error) as? Array;
                    if error == nil && managedObjectsArray != nil && managedObjectsArray!.count > 0 {
                        shouldInstantiateNewManagedObject = false
                        managedObject = managedObjectsArray![0]
                    }
                    else if error != nil{
                        DLog("Unresolved error \(error) \(error?.userInfo)")
                    }
                }
                if shouldInstantiateNewManagedObject{
                    managedObject = instantiateManagedObject(entityDescription:entityDescription, inManagedObjectContext:managedObjectContext)
                }
            }
            
            return managedObject
    }
    
    /**
    * Fetch or Create an NSManagedObject fulfilling the given predicate
    *
    * @param entityClass           The class of the entity to fetch
    * @param predicateFormat       The predicate to fulfill
    * @param dictionary            The dictionary that will update the NSManagedObject fetched before returning it
    * @param managedObjectContext  The NSManagedObjectContext where the fetch is performed
    *
    * @return an NSManagedObject fulfilling the given predicate and updated with the given dictionary
    */
    static func managedObject(  #entityClass:AnyClass,
                             predicateFormat:String?,
                        managedObjectContext:NSManagedObjectContext) -> NSManagedObject?{
            return managedObject(entityName:NSStringFromClass(entityClass), predicateFormat:predicateFormat,  managedObjectContext:managedObjectContext)
    }
    
    

    
    /**
    * Instantiate an NSManagedObject corresponding to the entity description in the NSManagedObjectContext and update it with a dictionary
    *
    * @param entityDescription     The entity description used to instantiate the NSManagedObject
    * @param dictionary            The dictionary that will update the NSManagedObject created before returning it
    * @param managedObjectContext  The NSManagedObjectContext where the instantiation is performed
    *
    * @return an instantiated NSManagedObject updated with the given dictionary
    */
    static func instantiateManagedObject(#entityDescription:NSEntityDescription,
                inManagedObjectContext managedObjectContext:NSManagedObjectContext) -> NSManagedObject?{
        let managedObject:NSManagedObject? = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        return managedObject;
    }
    
    
    
    /**
    * Fetch or create an NSManagedObject corresponding to the entity class. This method handles errors if the key paths or the keys in the given dictionary are not found
    *
    * @param entityName                    The name of the entity to fetch
    * @param predicateFormat               The predicate to fulfill
    * @param managedObjectKeyPathsArray    The array of keypaths to update in the NSManagedObject
    * @param dictionary                    The dictionary that will update the NSManagedObject before returning it
    * @param dictionaryKeyPathsArray       The array of keypaths to find in the dictionary
    * @param managedObjectContext          The NSManagedObjectContext where the fetch or instantiation is performed
    *
    * @note    managedObjectKeyPathsArray and dictionaryKeyPathsArray should have the same size
    *          each keypath of the NSManagedObject in managedObjectKeyPathsArray will be updated with the same index of the value from dictionaryKeyPathsArray
    *
    * @return an instantiated NSManagedObject updated with the given dictionary
    */
    static func managedObject(#entityName:String,
                          predicateFormat:String?,
                    managedObjectKeyPaths:[String]?,
          updateWithDictionary dictionary:Dictionary<String,AnyObject>?,
                       dictionaryKeyPaths:[String]?,
                     managedObjectContext:NSManagedObjectContext) -> NSManagedObject?{
            let managedObject:NSManagedObject? = GRCoreDataUtils.managedObject(entityName:entityName, predicateFormat:predicateFormat, managedObjectContext:managedObjectContext);
            let dictionaryKeyPathsArrayCount:Int = dictionaryKeyPaths!.count
            let managedObjectKeyPathsArrayCount:Int = managedObjectKeyPaths!.count

            for (var i = 0 ; i < dictionaryKeyPathsArrayCount ; i++){
                if i < dictionaryKeyPathsArrayCount && i < managedObjectKeyPathsArrayCount {
                    //cannot handle setValue:ForKeyPath: error yet, must wait for Swift 2.0
                    let managedObjectKeyPath = managedObjectKeyPaths?[i]
                    managedObject!.setValue((dictionary! as NSDictionary).valueForKeyPath(dictionaryKeyPaths![i]), forKeyPath: managedObjectKeyPath!)
                }
            }
            
            return managedObject;
    }
    
    /**
    * Fetch or create an NSManagedObject corresponding to the entity class. This method handles errors if the key paths or the keys in the given dictionary are not found
    *
    * @param entityClass                   The class of the entity to fetch
    * @param predicateFormat               The predicate to fulfill
    * @param managedObjectKeyPathsArray    The array of keypaths to update in the NSManagedObject
    * @param dictionary                    The dictionary that will update the NSManagedObject before returning it
    * @param dictionaryKeyPathsArray       The array of keypaths to find in the dictionary
    * @param managedObjectContext          The NSManagedObjectContext where the fetch or instantiation is performed
    *
    * @note    managedObjectKeyPathsArray and dictionaryKeyPathsArray should have the same size
    *          each keypath of the NSManagedObject in managedObjectKeyPathsArray will be updated with the same index of the value from dictionaryKeyPathsArray
    *
    * @return an instantiated NSManagedObject updated with the given dictionary
    */
    static func managedObject(#entityClass:AnyClass,
                           predicateFormat:String?,
                     managedObjectKeyPaths:[String]?,
           updateWithDictionary dictionary:Dictionary<String,AnyObject>?,
                        dictionaryKeyPaths:[String]?,
                      managedObjectContext:NSManagedObjectContext) -> NSManagedObject?{
            
            return managedObject(entityName:NSStringFromClass(entityClass),
                            predicateFormat:predicateFormat,
                      managedObjectKeyPaths:managedObjectKeyPaths,
                       updateWithDictionary:dictionary,
                         dictionaryKeyPaths:dictionaryKeyPaths,
                       managedObjectContext:managedObjectContext);
    }
    
    /**
    * Update an NSManagedObject with the given dictionary
    *
    * @param managedObject     The NSManagedObject to update
    * @param dictionary        The dictionary that will update the NSManagedObject
    */
    
    static func updateManagedObject(#managedObject:NSManagedObject?,
                         withDictionary dictionary:Dictionary<String,AnyObject>?){
        if managedObject != nil{
            for (key, value) in dictionary!{
                var obj:AnyObject? = nil
                switch(value){
                case let value as NSNull:
                    break;
                default:
                    obj = value;
                    break;
                }
                managedObject!.setValue(obj, forKeyPath: key);

            }
        }
        
    }
    
    
    /**
    * Fetch all NSManagedObjects fulfilling the predicate from the given NSManagedObjectContext
    *
    * @param entityName             The name of the entity to fetch
    * @param predicateFormat        The predicate to fulfill
    * @param managedObjectContext   The NSManagedObjectContext where the instantiation is performed
    *
    * @return an NSArray of NSManagedObjects fulfilling the predicate from the given NSManagedObjectContext
    */
    static func managedObjectsArray(forEntityName entityName:String,
                         withPredicateFormat predicateFormat:String?,
                 inManagedObjectContext managedObjectContext:NSManagedObjectContext) -> [AnyObject]? {
        let request:NSFetchRequest = NSFetchRequest(entityName: entityName);
        if(predicateFormat != nil){
            request.predicate = NSPredicate(format: predicateFormat!, argumentArray: nil);
        }
        var error:NSError? = nil;
        let managedObjectArray:[AnyObject]? = managedObjectContext.executeFetchRequest(request, error: &error);
        
        return managedObjectArray;
    }
    
    
    /**
    * Fetch all NSManagedObjects fulfilling the predicate from the given NSManagedObjectContext
    *
    * @param entityClass            The class of the entity to fetch
    * @param predicateFormat        The predicate to fulfill
    * @param managedObjectContext   The NSManagedObjectContext where the instantiation is performed
    *
    * @return an NSArray of NSManagedObjects fulfilling the predicate from the given NSManagedObjectContext
    */
    static func managedObjectsArray(forEntityClass entityClass:AnyClass,
                           withPredicateFormat predicateFormat:String?,
                   inManagedObjectContext managedObjectContext:NSManagedObjectContext) -> [AnyObject]? {
        return GRCoreDataUtils.managedObjectsArray(forEntityName: NSStringFromClass(entityClass), withPredicateFormat: predicateFormat, inManagedObjectContext: managedObjectContext);
    }
    
    /**
    * Delete all NSManagedObjects from the given class and fulfilling the given predicate and not present in managedObjectsArray
    *
    * @param managedObjectsArray   The array of NSManagedObjects to keep
    * @param entityClass           The class of the entity to fetch
    * @param predicateFormat       The predicate format to fulfill
    * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
    */
    /*+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectsArray
    forEntityClass:(Class)entityClass
    predicateFormat:(NSString *)predicateFormat
    inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;*/
    static func deleteManagedObjectsNotInArray(#managedObjectsArray:[AnyObject],
                                                        entityClass:AnyClass,
                                                    predicateFormat:String?,
                        inManagedObjectContext managedObjectContext:NSManagedObjectContext) {
        deleteManagedObjectsNotInArray(managedObjectsArray:managedObjectsArray, entityName:NSStringFromClass(entityClass), predicateFormat:predicateFormat, inManagedObjectContext: managedObjectContext);
    }
    
    /**
    * Delete all NSManagedObjects from the given name and fulfilling the given predicate and not present in managedObjectsArray
    *
    * @param managedObjectsArray   The array of NSManagedObjects to keep
    * @param entityName            The name of the entity to fetch
    * @param predicateFormat       The predicate format to fulfill
    * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
    */
    static func deleteManagedObjectsNotInArray(#managedObjectsArray:[AnyObject],
                                                         entityName:String,
                                                    predicateFormat:String?,
                        inManagedObjectContext managedObjectContext:NSManagedObjectContext) {
        //Fetch all managed objects satisfying "predicateFormat" and delete the ones not in "managedObjectsArray"
        //Should be rewrote
        if let allManagedObjectsArray:[AnyObject] = GRCoreDataUtils.managedObjectsArray(forEntityName: entityName, withPredicateFormat: predicateFormat, inManagedObjectContext: managedObjectContext){
            for managedObject:NSManagedObject in allManagedObjectsArray as! [NSManagedObject] {
                if !(managedObjectsArray as NSArray).containsObject(managedObject){
                    var shouldDeleteManagedObject:Bool = true;
                    for newManagedObject:NSManagedObject in managedObjectsArray as! [NSManagedObject]{
                        if newManagedObject.objectID.isEqual(managedObject){
                            shouldDeleteManagedObject = false
                            break
                        }
                    }
                    if shouldDeleteManagedObject{
                        managedObjectContext.deleteObject(managedObjectContext.objectWithID(managedObject.objectID))
                    }
                }
            }
        }
        var error:NSError? = nil
        if managedObjectContext.hasChanges && !managedObjectContext.save(&error) {
            DLog("Unresolved error \(error), \(error!.userInfo)")
        }
        
    }
    
    /**
    * Delete all NSManagedObjects from the given entity class
    *
    * @param entityClass           The class of the entity to fetch
    * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
    */
    static func deleteManagedObjects(   #entityClass:AnyClass,
         inManagedObjectContext managedObjectContext:NSManagedObjectContext){
        deleteManagedObjects(entityName:NSStringFromClass(entityClass), inManagedObjectContext:managedObjectContext)
    }
    /**
    * Delete all NSManagedObjects from the given entity name
    *
    * @param entityName            The name of the entity to fetch
    * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
    */
    static func deleteManagedObjects(   #entityName:String,
        inManagedObjectContext managedObjectContext:NSManagedObjectContext){
        if let allManagedObjectsArray:[AnyObject] = GRCoreDataUtils.managedObjectsArray(forEntityName: entityName, withPredicateFormat: nil, inManagedObjectContext: managedObjectContext){
            for managedObject:NSManagedObject in allManagedObjectsArray as! [NSManagedObject] {
                managedObjectContext.deleteObject(managedObject)
            }
        }
        var error:NSError? = nil;
        if managedObjectContext.hasChanges && !managedObjectContext.save(&error) {
            DLog("Unresolved error \(error), \(error!.userInfo)")
        }
    }
    
    /**
    * Instantiate and return an NSFetchedResultsController for an entity with the given name
    *
    * @param entityName            The name of the entity to fetch
    * @param delegate              The delegate of the NSFetchedResultsController
    * @param predicateFormat       The predicate format to fulfill
    * @param sortDescriptors       The array of descriptors for the NSFetchedResultsController
    * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
    * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
    *
    * @return an NSFetchedResultsController for the given managedObjectContext
    */
    
    static func fetchedResultsController(#entityName:String,
                                            delegate:NSFetchedResultsControllerDelegate?,
                                     predicateFormat:String?,
                                     sortDescriptors:[NSSortDescriptor],
                                  sectionNameKeyPath:String?,
                                managedObjectContext:NSManagedObjectContext) -> NSFetchedResultsController{
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: entityName)
        if predicateFormat != nil{
            fetchRequest.predicate = NSPredicate(format: predicateFormat!, argumentArray: nil)
        }
        fetchRequest.sortDescriptors = sortDescriptors;
        let fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: sectionNameKeyPath, cacheName: nil);
        fetchedResultsController.delegate = delegate;
        var error:NSError? = nil;
        fetchedResultsController.performFetch(&error)
        if error != nil{
            DLog("\(error)");
        }
        return fetchedResultsController;
    }
    
    /**
    * Instantiate and return an NSFetchedResultsController for an entity with the given class
    *
    * @param entityClass           The class of the entity to fetch
    * @param delegate              The delegate of the NSFetchedResultsController
    * @param predicateFormat       The predicate format to fulfill
    * @param sortDescriptors       The array of descriptors for the NSFetchedResultsController
    * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
    * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
    *
    * @return an NSFetchedResultsController for the given managedObjectContext
    */
    
    static func fetchedResultsController(#entityClass:AnyClass,
                                             delegate:NSFetchedResultsControllerDelegate?,
                                      predicateFormat:String?,
                                      sortDescriptors:[NSSortDescriptor],
                                   sectionNameKeyPath:String?,
                                 managedObjectContext:NSManagedObjectContext) -> NSFetchedResultsController{
            return fetchedResultsController(entityName:NSStringFromClass(entityClass),
                                              delegate:delegate,
                                       predicateFormat:predicateFormat,
                                       sortDescriptors:sortDescriptors,
                                    sectionNameKeyPath:sectionNameKeyPath,
                                  managedObjectContext:managedObjectContext);
    }
    
    
    
}