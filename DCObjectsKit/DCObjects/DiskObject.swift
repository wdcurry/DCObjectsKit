//
//  DiskObject.swift - base object for DC (Disk Cache) objects
//      methods to store data object to UserDocs and be retrievable via a file name
//
//  Created by drew curry on 2018-11-24.
//  Copyright © 2018 yinApps. All rights reserved.
//

import Foundation

class DiskObject: NSObject {
    
    var fileName: String? = nil
    var dataOnDisk: Data? = nil
    
    public required convenience init<T>(withObject object: T) {
        self.init()
        self.fileName = ""
        self.dataOnDisk = nil
        setDiskObject(newValue: object)
    }
    
    public convenience init<T>(withFileName: String, objectOnDisk: inout T? ) {
        self.init()
        fileName = withFileName
        objectOnDisk = getDiskObject()
    }
    
    public func setDiskObject<T>(newValue: T) {
        let response = U.saveObject(data: newValue)
        if !response.fileName.isEmpty {
            fileName = response.fileName
            dataOnDisk = response.data
        } else {
            //TODO: this is not ideal, but likely won't happen, should throw instead.
            fileName = ""
            dataOnDisk = nil
        }
    }
    
    public func getDiskObject<T>() -> T? {
        if let savedDiskObject = dataOnDisk {
            return savedDiskObject as? T
        } else {
            //try obtaining the diskobject from filepath
            if let savedFileName = fileName {
                //grab data from stored object file, save and return it
                if let savedDiskObject: T? = U.getObject(fileName: savedFileName) {
                    return savedDiskObject
                }
            }
        }
        //we have no stored object, return nil
        return nil
    }
    
}
