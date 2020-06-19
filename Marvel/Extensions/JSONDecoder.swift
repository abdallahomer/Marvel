//
//  JSONDecoder.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

extension JSONDecoder {
    static func decode<T: Decodable>(data: Data, type: T.Type? = nil) -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try! decoder.decode(T.self, from: data)
        return decodedData
    }
}
