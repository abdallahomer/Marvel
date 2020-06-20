//
//  CharactersModel.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

protocol CharactersModelLogic {
    func getCharactersData(parameters: [String: Any], completionHandler: @escaping (Bool, CharacterResponse.Data?) -> ())
}

class CharactersModel: CharactersModelLogic {
    func getCharactersData(parameters: [String: Any], completionHandler: @escaping (Bool, CharacterResponse.Data?) -> ()) {
        guard let url = URL(string: BASE_URL) else {return}
        
        let cacheKey = "\(url.description)\(parameters.description)"
        
        func getCached() -> CharacterResponse.Data? {
            try? cache.value(forKey: cacheKey)
        }
        
        API.getDataWith(url: url, parameters) { (success, data) in
            if success {
                let response = JSONDecoder.decode(data: data!, type: CharacterResponse.self)
                if response.code == SUCCESS_STATUS {
                    try? self.cache.set(value: response.data!, forKey: cacheKey)
                    completionHandler(true, response.data!)
                } else {
                    if let cached = getCached() {
                        completionHandler(true, cached)
                    } else {
                        completionHandler(false, nil)
                    }
                }
            } else {
                if let cached = getCached() {
                    completionHandler(true, cached)
                } else {
                    completionHandler(false, nil)
                }
            }
        }
    }
    
    init(cache: CacheProtocol = RealmCache()) {
        self.cache = cache
    }
    
    private let cache: CacheProtocol
}
