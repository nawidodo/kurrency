//
//  UserDefaults+Extensions.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 13/09/21.
//

import Foundation

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String)  where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type)  -> Object? where Object: Decodable
}

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) where Object: Encodable {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(object)
        set(data, forKey: forKey)
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) -> Object? where Object: Decodable {
        guard let data = data(forKey: forKey) else { return nil }
        let decoder = JSONDecoder()
        let object = try? decoder.decode(type, from: data)
        return object
    }
}

