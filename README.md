# GRCoreDataUtilsSwift
A simple and easy to use utility class to retrieve (via NSFetchedResultsController), insert, update and delete data using CoreData


How To Use
----------

## GRCoreDataUtils

* I do not recommend using directly the methods from GRCoreDataUtils.
  Use it with the extension GRCoreDataUtils+AppDelegate and extends GRCoreDataUtils to a DAO class (see UserDAO in SampleGRCoreDataUtils) *

### Entity used for sample code
 
```swift
// User
import Foundation
import CoreData
@objc(User)

class User: NSManagedObject {

    @NSManaged var firstname: String?
    @NSManaged var lastname: String?
    @NSManaged var userId: String?

}


...

```

### Insert and/or update data

```swift

// UserDAO


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
```

### Delete data
```swift
// UserDAO
static func deleteUser(user:User){
        deleteManagedObject(user);
        saveDatabase()
}
```

### Get FetchedResultsController

```swift
static func fetchedResultsControllerWithDelegate(#delegate:NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController?{
        return fetchedResultsController(entityClass: User.self,
                                           delegate: delegate,
                                    sortDescriptors: [
                                                        NSSortDescriptor(key: "firstname", ascending: true),
                                                        NSSortDescriptor(key: "lastname", ascending: true)
                                                    ] as [NSSortDescriptor],
                                 sectionNameKeyPath: nil);
}
```

Installation
------------

### Dependencies

This project requires the CoreData framework added to your Xcode project


### Integration

Currently, there are two ways to use GRCoreDataUtils :
- downloading the repository and dragging the GRCoreDataUtils folder
- adding the repository as a submodule of your project and dragging the same files.

* This project will be available in the future on CocoaPods *

## License
The MIT License (MIT)

Copyright (c) 2015 gnatsel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.