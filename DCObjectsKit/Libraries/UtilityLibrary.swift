//
//  UtilityLibrary.swift - basic functions not app-centric
//  ResultZapp
//
//  Created by drew curry on 2018-11-25.
//  Copyright © 2018 yinApps. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift
import FileKit

enum AppFolder: String {
    case Memes = "Memes"
}

public class Utility {
    
}

extension Utility {
    //manage pack and unpack of data, which simply serializes an object or deserializes an object
    //  The companion functions need to save to disk
    static func saveObject<T>(data objectToSave: T) -> (fileName: String, data: Data?) {
        //packs data to disk,
        do {
            //grab type of object to help create a more useful filename
            //use a prefex that describes the file, with is sugar of course.
            
            let thisType = type(of: objectToSave)
            let thisType1 = String(describing: thisType)
            let descriptiveFileName = thisType1 + "_" + String.random(ofLength: 8)
            
            let filePath = getFilePathInUserDocs(fileName: descriptiveFileName)
            print("saving filepath: \(filePath)")
            //let path: Path = Path(fileName)
            let dataToSave: Data? = try NSKeyedArchiver.archivedData(withRootObject: objectToSave, requiringSecureCoding: false)
            
            do {
                if let checkedDataToSave = dataToSave {
                    try checkedDataToSave.write(to: filePath)
                    return (fileName: filePath.fileName, data: dataToSave )
                }
            } catch {
                print("saveObject<T> failed.  Couldn't save file: \(filePath)")
            }
        } catch {
            print("Couldn't save data.")
        }
        return (fileName: "", data: nil)
    }
    
    static func getObject<T>(object data: Data) -> T? {
        //when we already have data, and only want to coelesce object
        do {
            if let returnObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T {
                return returnObject
            }
        } catch {
            print(error)    // << needs to be setup
        }
        return nil
    }
    
    static func getObject<T>(fileName objectFileNameToGet: String) -> T? {
        //unpacks data from disk
        do {
            let filePath = getFilePathInUserDocs(fileName: objectFileNameToGet)
            print("get filepath: \(filePath)")

            let fileURL = URL(fileURLWithPath: filePath.standardRawValue)

            let data = try Data.init(contentsOf: fileURL)
            print("type T: \(T.self)")
            
            if let returnObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! T? {
                return returnObject
            }

        } catch {
            print("getObject<T> failed: Couldn't get file: \(objectFileNameToGet)")
        }
        return nil
    }
    
    static func getAppUserDocs() -> Path {
        //A simple and convenient funciton to get the userdocs folder
        return Path.init(Path.userDocuments.standardRawValue)
    }

    static func getFilePathInUserDocs(fileName: String = String.random(ofLength: 8)) -> Path {
        //create proper filepath for supplied filename or create random name if required.
        //  no file extension, let app manage, could augment with enum and T lookup

        let fullPath = Path.init(Path.userDocuments.standardRawValue.appendingPathComponent(fileName))
        print("calc'd filepath: \(fullPath)")
        return fullPath
    }
}



extension Utility {

}
