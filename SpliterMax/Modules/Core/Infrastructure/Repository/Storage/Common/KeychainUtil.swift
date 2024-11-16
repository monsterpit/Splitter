//
//  KeychainUtil.swift
//  Splitter
//
//  Created by Vikas Salian on 01/11/24.
//

import Foundation

enum KeychainUtil {
    private static func passwordQuery(forKey key: String, service: String, group: String?, accessible: String) -> [String: Any] {
        var query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccessible as String: accessible,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service
        ] as [String: Any]
        if let group = group {
            query[kSecAttrAccessGroup as String] = group
        }
        return query
    }
    
    @discardableResult
    static func set(_ data: Data?, forKey key: String, service: String, group: String?, accessible: String) -> Bool {
        var query = passwordQuery(forKey: key, service: service, group: group, accessible: accessible)
        guard let data = data else {
            return (SecItemDelete(query as CFDictionary) == noErr)
        }
        query[kSecValueData as String] = data
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == noErr
    }
    
    @discardableResult
    static func get(forKey key: String, service: String, group: String?, accessible: String) -> Data? {
        var query = passwordQuery(forKey: key, service: service, group: group, accessible: accessible)
        query[kSecReturnData as String] = kCFBooleanTrue as Any
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        
        var dataRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataRef)
        if status == noErr {
            return dataRef as? Data
        }
        return nil
    }
    
    @discardableResult
    static func remove(forKey key: String, service: String, group: String?, accessible: String) -> Bool {
        let query = passwordQuery(forKey: key, service: service, group: group, accessible: accessible)
        return (SecItemDelete(query as CFDictionary) == noErr)
    }
}
