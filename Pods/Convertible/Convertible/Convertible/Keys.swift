//
//  Keys2.swift
//  Convertible
//
//  Created by Bradley Hilton on 9/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public typealias PropertyKey = String
public typealias MappedKey = String

public protocol KeyMapping {
    
    static var ignoredKeys: Set<PropertyKey> { get }
    static var keyMapping: [PropertyKey : MappedKey] { get }
    static func mappedKeyForPropertyKey(propertyKey: PropertyKey) -> MappedKey?
    
}

public protocol UnderscoreToCamelCase : KeyMapping {}

extension KeyMapping {
    
    public static var ignoredKeys: Set<PropertyKey> {
        return []
    }
    
    public static var keyMapping: [PropertyKey : MappedKey] {
        return [:]
    }
    
    public static func mappedKeyForPropertyKey(propertyKey: PropertyKey) -> MappedKey? {
        guard !ignoredKeys.contains(propertyKey) else { return nil }
        if let mappedKey = keyMapping[propertyKey] {
            return mappedKey
        } else {
            return propertyKey
        }
    }
    
}

extension UnderscoreToCamelCase {
    
    public static func mappedKeyForPropertyKey(propertyKey: PropertyKey) -> MappedKey? {
        guard !ignoredKeys.contains(propertyKey) else { return nil }
        if let mappedKey = keyMapping[propertyKey] {
            return mappedKey
        } else {
            return underscoreFromCamelCase(propertyKey)
        }
    }
    
    static func underscoreFromCamelCase(camelCase: PropertyKey) -> MappedKey {
        let options = NSStringEnumerationOptions.ByComposedCharacterSequences
        let range = camelCase.startIndex..<camelCase.endIndex
        var underscore = ""
        camelCase.enumerateSubstringsInRange(range, options: options) { (substring, substringRange, enclosingRange, shouldContinue) -> () in
            if let substring = substring {
                if substring.lowercaseString != substring {
                    underscore += "_" + substring.lowercaseString
                } else {
                    underscore += substring
                }
            }
        }
        return underscore
    }
    
}

