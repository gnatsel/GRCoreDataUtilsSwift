//
//  UserPresenter.swift
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Revilo on 17/08/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

import UIKit

class UserPresenter: GRPresenter {
    @IBOutlet weak var fullnameLabel: UILabel?
    @IBOutlet weak var lastnameTextField: UITextField?
    @IBOutlet weak var firstnameTextField: UITextField?
    
    override func configureWithEntity(#entity: AnyObject) {
        super.configureWithEntity(entity:entity);
        if(entity.isKindOfClass(User)){
            configureWithUser(user: entity as! User)
        }
    }
    
    func configureWithUser(#user:User){
        configureFullNameLabelWithUser(user: user)
        configureFirstnameTextFieldWithUser(user: user)
        configureLastnameTextFieldWithUser(user: user)
    }
    
    private func configureFullNameLabelWithUser(#user:User){
        if(fullnameLabel != nil){
            var fullnameString = "";
            if( (user.firstname != nil) && (user.lastname != nil)){
                fullnameString = String(format: "%@ %@", user.firstname!, user.lastname!)
            }
            else if(user.firstname == nil && user.lastname != nil){
                fullnameString = user.firstname!
            }
            else if(user.firstname != nil && user.lastname == nil){
                fullnameString = user.lastname!
            }
            fullnameLabel!.text = fullnameString;
        }
    }
    
    private func configureFirstnameTextFieldWithUser(#user:User){
        if(firstnameTextField != nil){
            firstnameTextField!.text = user.firstname
        }
    }
    
    private func configureLastnameTextFieldWithUser(#user:User){
        if(lastnameTextField != nil){
            lastnameTextField!.text = user.lastname
        }
    }
    
    override func dictionaryEntity() -> Dictionary<String,AnyObject> {
        var dictionaryEntity = super.dictionaryEntity()
        if(firstnameTextField != nil){
            dictionaryEntity["firstname"] = firstnameTextField!.text
        }
        if(lastnameTextField != nil){
            dictionaryEntity["lastname"] = lastnameTextField!.text
        }
        return dictionaryEntity
    }
}
