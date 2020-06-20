//
//  Collection.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
