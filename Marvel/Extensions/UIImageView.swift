//
//  UIImageView.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func download(image url: URL?) {
        guard let url = url else { return }
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}
