//
//  RealmCache.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import RealmSwift

class RealmCache {
    private func getRealm() throws -> Realm { try Realm() }
}

class CacheRecord: Object {
    @objc dynamic var key = ""
    @objc dynamic var value = Data()
    
    override static func primaryKey() -> String? {
        return "key"
    }
}

extension RealmCache: CacheProtocol {
    func set<T>(value: T, forKey key: String) throws where T : Encodable {
        let encodedValue = try JSONEncoder().encode(value)
        let realm = try getRealm()
        
        let record = CacheRecord()
        record.key = key
        record.value = encodedValue
        
        try realm.write {
            realm.add(record, update: .modified)
        }
    }
    
    func value<T>(forKey key: String) throws -> T? where T : Decodable {
        guard let record = try getRealm().object(ofType: CacheRecord.self, forPrimaryKey: key) else { return nil }
        return try JSONDecoder().decode(T.self, from: record.value)
    }
}
