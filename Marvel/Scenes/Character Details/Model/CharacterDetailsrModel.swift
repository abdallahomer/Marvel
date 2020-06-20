//
//  CharacterModel.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

enum ActionType: String {
    case comics
    case series
    case stories
    case events
}

struct ActionsResponse: Codable {
    let code: Int
    let data: Data?
    
    struct Data: Codable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [Results]
        
        struct Results: Codable {
            let title: String
            let thumbnail: Thumbnail?
            
            struct Thumbnail: Codable {
                let path: String
                let `extension`: String
            }
        }
    }
}

protocol CharacterDetailsModelLogic {
    func getActionsDataFor(characterId: Int, actionType: ActionType, completionHandler: @escaping (Bool, ActionsResponse.Data?) -> ())
}

class CharacterDetailsModel: CharacterDetailsModelLogic {
    func getActionsDataFor(characterId: Int, actionType: ActionType, completionHandler: @escaping (Bool, ActionsResponse.Data?) -> ()) {
        guard let url = URL(string: BASE_URL + "/\(characterId)" + "/\(actionType.rawValue)") else {return}
        
        let cacheKey = "\(url.description)\(characterId)\(actionType)"
        
        func getCached() -> ActionsResponse.Data? {
            try? cache.value(forKey: cacheKey)
        }
        
        API.getDataWith(url: url) { (success, data) in
            if success {
                let response = JSONDecoder.decode(data: data!, type: ActionsResponse.self)
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
