//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

protocol CharacterDetailsViewLogic: IndicatorProtocol {
    func setupNaviationItems()
    func setCharacterTitle()
    
    var characterName: String? {get}
    var characterDescription: String? {get}
    var characterImageURL: CharacterResponse.Data.Results.Thumbnail? {get}
    var characterLinks: [CharacterResponse.Data.Results.URLs]? {get}
    
    func configureLinksStackViewsWith(title: String) -> UIStackView
}

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var characterData: CharacterResponse.Data.Results?
    
    private enum CellNumbers: Int {
        case thumbnailCell
        case detailsCell
        case actionsCell
        case relatedLinksCell
    }
    private lazy var presenter: CharacterDetailsPresenterLogic = {
       return CharacterDetailsPresenter(view: self, model: CharacterDetailsModel())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension CharacterDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CellNumbers(rawValue: indexPath.row) {
        case .thumbnailCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "thumbnailCell", for: indexPath) as! CharacterThumbnailCell
            presenter.configure(cell, at: indexPath.row)
            
            return cell
        case .detailsCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! CharacterDetailsCell
            presenter.configure(cell, at: indexPath.row)
            
            return cell
        case .actionsCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "actionsCell", for: indexPath) as! CharacterActionsCell
            presenter.configure(cell, at: indexPath.row)
            
            return cell
        case .relatedLinksCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "relatedLinksCell", for: indexPath) as! CharacterRelatedLinksCell
            presenter.configure(cell, at: indexPath.row)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension CharacterDetailsViewController: UITableViewDelegate {
    
}

extension CharacterDetailsViewController: CharacterDetailsViewLogic {
    var characterName: String? { characterData?.name }
    
    var characterDescription: String? { characterData?.description }
    
    var characterImageURL: CharacterResponse.Data.Results.Thumbnail? { characterData?.thumbnail }
    
    var characterLinks: [CharacterResponse.Data.Results.URLs]? { characterData?.urls }
    
    func setupNaviationItems() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: -56,left: 0,bottom: 0,right: 0);
    }
    
    func setCharacterTitle() {
        title = characterData?.name
    }
    
    func configureLinksStackViewsWith(title: String) -> UIStackView {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        let arrow = UIImageView(image: UIImage(named: "icn-cell-disclosure"))
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(arrow)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
}
