//
//  CharacterDetailsTableViewCell.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

protocol CharacterThumbnailCellProtocol: AnyObject {
    var thumbnailImageURL: String? {set get}
}

protocol CharacterDetailsCellProtocol: AnyObject {
    var nameTitle: String? {set get}
    var characterDescription: String? {set get}
}

protocol CharacterRelatedLinksCellProtocol: AnyObject {
    var stackView: UIStackView? {set get}
}

class CharacterThumbnailCell: UITableViewCell, CharacterThumbnailCellProtocol {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var thumbnailImageURL: String? {
        didSet {
            thumbnailImageView.download(image: URL(string: thumbnailImageURL ?? ""))
        }
    }
}

class CharacterDetailsCell: UITableViewCell, CharacterDetailsCellProtocol {
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var nameTitle: String? {
        didSet {
            nameTitleLabel.text = nameTitle
        }
    }
    
    var characterDescription: String? {
        didSet {
            descriptionLabel.text = characterDescription
        }
    }
}

class CharacterActionsCell: UITableViewCell {
    @IBOutlet weak var actionTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false)
        collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}

class CharacterRelatedLinksCell: UITableViewCell, CharacterRelatedLinksCellProtocol {
    @IBOutlet weak var linksStackView: UIStackView!
    
    var stackView: UIStackView? {
        didSet {
            stackView?.addArrangedSubview(stackView ?? UIStackView())
            stackView?.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
