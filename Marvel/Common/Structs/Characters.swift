//
//  Characters.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

struct CharacterResponse: Codable {
    let code: Int
    let data: Data?
    
    struct Data: Codable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [Results]
        
        struct Results: Codable {
            let id: Int
            let name: String
            let description: String
            let thumbnail: Thumbnail?
            let urls: [URLs]
            
            struct Thumbnail: Codable {
                let path: String
                let `extension`: String
            }
            
            struct URLs: Codable {
                let url: String
                let type: String
            }
        }
    }
}
