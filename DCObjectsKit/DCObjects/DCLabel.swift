//
//  DCLabel.swift - Disk Cache UILabel
//  ResultZapp
//
//  Created by drew curry on 2018-11-28.
//  Copyright © 2018 yinApps. All rights reserved.
//

import Foundation
import UIKit

class DCLabel: NSObject {
    
    var objectID: String? = ""
    var diskObject: DiskObject = DiskObject()
    var cachedObject: UILabel? = nil
    
    public required convenience init(id: String) {

        self.init()
        objectID = id
        //activate the get() which will instantiate the label
        cachedObject = label
        
    }

    public required convenience init(withObject object: UILabel) {
        
        self.init()
        label = object
        
    }
    
    var label: UILabel? { // read-only properties are automatically ignored
        get {
            if let cachedObject = cachedObject {
                return cachedObject
            }
            if let checkedObjectID = objectID {
                //TODO: names here suck
                diskObject.fileName = checkedObjectID
                if let checkedObject: UILabel = diskObject.getDiskObject() {
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
