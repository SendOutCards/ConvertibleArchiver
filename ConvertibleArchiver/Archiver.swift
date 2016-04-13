//
//  Archiver.swift
//  ConvertibleArchiver
//
//  Created by Bradley Hilton on 4/12/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Convertible

public struct NilLiteral : NilLiteralConvertible {
    public init(nilLiteral: ()) {}
}

public enum Archiver {
    
    public static func save<T : DataSerializable>(value value: T?, key: String) {
        guard let value = value else { remove(key: key); return }
        _ = try? (try? value.serializeToData())?.writeToFile(filePath(key), options: [])
    }
    
    public static func save(value value: NilLiteral, key: String) {
        remove(key: key)
    }
    
    public static func remove(key key: String) {
        _ = try? NSFileManager.defaultManager().removeItemAtPath(filePath(key))
    }
    
    public static func restore<T : DataInitializable>(type type: T.Type = T.self, key: String, bundle: NSBundle? = nil) -> T? {
        do {
            let data = try NSData(contentsOfFile: filePath(key), options: [])
            return try T.initializeWithData(data)
        } catch {
            guard let bundle = bundle else { return nil }
            return restoreFromBundle(key: key, bundle: bundle)
        }
    }
    
    private static func restoreFromBundle<T : DataInitializable>(key key: String, bundle: NSBundle) -> T? {
        guard let bundleFilePath = bundle.pathForResource(key, ofType: nil),
            let data = NSData(contentsOfFile: bundleFilePath),
            let value = try? T.initializeWithData(data) else {
            return nil
        }
        return value
    }
    
    private static func filePath(key: String) -> String {
        return documentDirectory + key
    }
    
    private static var documentDirectory: String {
        if let directoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first {
            return directoryPath
        }
        return ""
    }
    
}
