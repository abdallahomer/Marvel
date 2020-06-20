//
//  ImageViewerViewController.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

protocol ImageViewerViewLogic: IndicatorProtocol {
    func dismissView()
    func showMediaData()
}

class ImageViewerViewController: UIViewController {
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    
    var mediaData: ActionsResponse.Data.Results?
    
    private lazy var presenter = {
        return ImageViewPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func dismissButtonDidTapped(_ sender: UIButton) {
        presenter.dismissButtonDidTapped()
    }
}

extension ImageViewerViewController: ImageViewerViewLogic {
    func showMediaData() {
        let path = mediaData?.thumbnail?.path ?? ""
        let `extension` = mediaData?.thumbnail?.extension ?? ""
        mediaImageView.download(image: URL(string: path + "." + `extension`))
        
        mediaTitleLabel.text = mediaData?.title
    }
    
    func dismissView() {
        dismiss(animated: false, completion: nil)
    }
}
