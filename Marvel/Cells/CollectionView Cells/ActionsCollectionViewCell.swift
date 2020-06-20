//
//  ActionsCollectionViewCell.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

protocol ActionCollectionViewCellProtocol: AnyObject {
    var actionImageURL: String? {set get}
    var actionTitle: String? {set get}
}

class ActionsCollectionViewCell: UICollectionViewCell, ActionCollectionViewCellProtocol {
    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var actionTitleLabel: UILabel!
    
    var actionImageURL: String? {
        didSet {
            actionImageView.download(image: URL(string: actionImageURL ?? ""))
        }
    }
    
    var actionTitle: String? {
        didSet {
            actionTitleLabel.text = actionTitle
        }
    }
}
