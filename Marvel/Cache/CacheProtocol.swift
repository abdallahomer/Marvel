//
//  CacheProtocol.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

protocol CacheProtocol {
    func set<T: Encodable>(value: T, forKey key: String) throws
    func value<T: Decodable>(forKey key: String) throws -> T?
}
