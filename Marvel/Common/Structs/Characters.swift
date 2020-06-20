//
//  Characters.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

struct CharacterResponse: Decodable {
    let code: Int
    let data: Data?
    
    struct Data: Decodable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [Results]
        
        struct Results: Decodable {
            let id: Int
            let name: String
            let description: String
            let thumbnail: Thumbnail?
            
            struct Thumbnail: Decodable {
                let path: String
                let `extension`: String
            }
        }
    }
}
