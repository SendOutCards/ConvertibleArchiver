//
//  Archiver.swift
//  ConvertibleArchiver
//
//  Created by Bradley Hilton on 4/12/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Convertible

public struct NilLiteral : ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {}
}

public enum Archiver {
    
    public static func save<T : DataSerializable>(value: T?, key: String) {
        guard let value = value else { remove(key: key); return }
        _ = try? (try? value.serializeToData())?.write(to: URL(fileURLWithPath: filePath(key)))
    }
    
    public static func save(value: NilLiteral, key: String) {
        remove(key: key)
    }
    
    public static func remove(key: String) {
        _ = try? FileManager.default.removeItem(atPath: filePath(key))
    }
    
    public static func restore<T : DataInitializable>(type: T.Type = T.self, key: String, bundle: Bundle? = nil) -> T? {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath(key)), options: [])
            return try T.initializeWithData(data)
        } catch {
            guard let bundle = bundle else { return nil }
            return restoreFromBundle(key: key, bundle: bundle)
        }
    }
    
    private static func restoreFromBundle<T : DataInitializable>(key: String, bundle: Bundle) -> T? {
        guard let bundleFilePath = bundle.path(forResource: key, ofType: nil),
            let data = try? Data(contentsOf: URL(fileURLWithPath: bundleFilePath)),
            let value = try? T.initializeWithData(data) else {
            return nil
        }
        return value
    }
    
    private static func filePath(_ key: String) -> String {
        return documentDirectory + key
    }
    
    private static var documentDirectory: String {
        if let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            return directoryPath + "/"
        }
        return ""
    }
    
}
