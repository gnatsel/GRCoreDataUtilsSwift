//
//  User.swift
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Revilo on 17/08/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

import Foundation
import CoreData
@objc(User)

class User: NSManagedObject {

    @NSManaged var firstname: String?
    @NSManaged var lastname: String?
    @NSManaged var userId: String?

}
