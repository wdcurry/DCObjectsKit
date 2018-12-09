//
//  DCImage.swift - Disk Cache UIImage
//  ResultZapp
//
//  Created by drew curry on 2018-11-28.
//  Copyright © 2018 yinApps. All rights reserved.
//

import Foundation
import UIKit

class DCImage: NSObject {
    
    var objectID: String? = ""
    var diskObject: DiskObject = DiskObject()
    var cachedObject: UIImage? = nil
    
    public required convenience init(id: String) {
        
        self.init()
        objectID = id
        //activate the get() which will instantiate the label
        cachedObject = image
        
    }
    
    public required convenience init(withObject object: UIImage) {
        
        self.init()
        image = object
        
    }

    var image: UIImage? { // read-only properties are automatically ignored
        get {
            if let cachedObject = cachedObject {
                return cachedObject
            }
            if let checkedObjectID = objectID {
                //TODO: names here suck
                diskObject.fileName = checkedObjectID
                //this is the key, the Generic T of the diskObject
                if let checkedObject: UIImage = diskObject.getDiskObject() {
                    cachedObject = checkedObject
                    return checkedObject
                }
            }
            return nil
        }
        
        set {
            diskObject = DiskObject.init(withObject: newValue)
            objectID = diskObject.fileName
            cachedObject = newValue
        }
    }
}
