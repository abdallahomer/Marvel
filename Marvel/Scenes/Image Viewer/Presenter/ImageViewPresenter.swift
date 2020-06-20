//
//  ImageViewPresenter.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

protocol ImageViewPresenterLogic {
    func viewDidLoad()
    func dismissButtonDidTapped()
}

class ImageViewPresenter {
    private weak var view: ImageViewerViewLogic?
    
    init(view: ImageViewerViewLogic) {
        self.view = view
    }
}

extension ImageViewPresenter: ImageViewPresenterLogic {
    func viewDidLoad() {
        view?.showMediaData()
    }
    
    func dismissButtonDidTapped() {
        view?.dismissView()
    }
}
