//
//  CharacterDetailsTableViewCell.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

class CharacterThumbnailCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
}

class CharacterDetailsCell: UITableViewCell {
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

class CharacterActionsCell: UITableViewCell {
    @IBOutlet weak var actionTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
}

class CharacterRelatedLinksCell: UITableViewCell {
    @IBOutlet weak var stackView: UIStackView!
}
