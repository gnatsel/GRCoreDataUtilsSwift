//
//  EditUserViewController.swift
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Revilo on 17/08/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

import UIKit
import CoreData

class EditUserViewController: UIViewController {
    var currentUser:User?;
    override func viewDidLoad() {
        super.viewDidLoad()
        if(currentUser != nil){
            self.title = "Edit User"
            self.view.presenter!.configureWithEntity(entity: currentUser!)
        }
        else{
            self.title = "Create User"
        }
    }
    
    
    @IBAction func validateAction(sender: AnyObject) {
        var dictionaryEntity:Dictionary<String,AnyObject> = view.presenter!.dictionaryEntity()
        if(currentUser != nil){
            UserDAO.updateManagedObject(managedObject: currentUser! as NSManagedObject, withDictionary: dictionaryEntity);
        }
        else{
            dictionaryEntity["userId"] = NSUUID().UUIDString
            UserDAO.userUpdatedWithDictionary(dictionaryEntity);
        }
        UserDAO.saveDatabase()
        navigationController!.popViewControllerAnimated(true);
    }
}
