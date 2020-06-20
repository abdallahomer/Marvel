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
    
    var characterId: Int? {get}
    var characterName: String? {get}
    var characterDescription: String? {get}
    var characterImageURL: CharacterResponse.Data.Results.Thumbnail? {get}
    var characterLinks: [CharacterResponse.Data.Results.URLs]? {get}
    
    func configureLinksStackViewsWith(title: String) -> UIStackView
    
    func reloadData()
}

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var characterData: CharacterResponse.Data.Results?
    
    private enum CellIdentifier: String {
        case thumbnailCell
        case actionsCell
        case detailsCell
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 3:
            return 1
        default:
            return presenter.TableViewCellCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.thumbnailCell.rawValue, for: indexPath) as! CharacterThumbnailCell
            presenter.configure(cell, at: indexPath.row)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.detailsCell.rawValue, for: indexPath) as! CharacterDetailsCell
            presenter.configure(cell, at: indexPath.row)
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.relatedLinksCell.rawValue, for: indexPath) as! CharacterRelatedLinksCell
            presenter.configure(cell, at: indexPath.row)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.actionsCell.rawValue, for: indexPath) as! CharacterActionsCell
            presenter.configure(cell, at: indexPath.row)
            
            return cell
        }
    }
}

extension CharacterDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            guard let cell = cell as? CharacterActionsCell else { return }
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            presenter.tableViewWillDisplayAt(cell, at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            guard let cell = cell as? CharacterActionsCell else { return }
            presenter.tableViewDidEndDisplayingAt(cell, at: indexPath.row)
        }
    }
}

extension CharacterDetailsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.actions[safe: collectionView.tag]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actionCollectionViewCell", for: indexPath) as! ActionsCollectionViewCell
        presenter.configure(cell, at: collectionView.tag, childRow: indexPath.row)
        return cell
    }
}

extension CharacterDetailsViewController: UICollectionViewDelegate {
    
}

extension CharacterDetailsViewController: CharacterDetailsViewLogic {
    var characterId: Int? { characterData?.id}
    
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
    
    func reloadData() {
        tableView.reloadData()
    }
}
