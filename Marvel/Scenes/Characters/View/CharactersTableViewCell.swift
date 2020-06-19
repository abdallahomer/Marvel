//
//  CharactersTableViewCell.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

protocol CharactersTableViewCellLogic: AnyObject {
    var characterImageURL: String? {set get}
    var characterTitle: String? {set get}
}

class CharactersTableViewCell: UITableViewCell, CharactersTableViewCellLogic {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterTitleLabel: UILabel!
    
    var characterImageURL: String? {
        didSet {
            characterImageView.download(image: URL(string: characterImageURL ?? ""))
        }
    }
    
    var characterTitle: String? {
        didSet {
            characterTitleLabel.text = characterTitle
        }
    }
}
