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
    func setupPresentation()
    
    var characterId: Int? {get}
    var characterName: String? {get}
    var characterDescription: String? {get}
    var characterImageURL: CharacterResponse.Data.Results.Thumbnail? {get}
    var characterLinks: [CharacterResponse.Data.Results.URLs]? {get}
    
    func configureLinksStackViewsWith(title: String) -> UIStackView
    func reloadData()
    
    func presentMediaDataWith(data: ActionsResponse.Data.Results)
}

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var characterData: CharacterResponse.Data.Results?
    
    private let sectionsNumber = 4
    private enum SectionNumbers: Int {
        case thumbnail = 0
        case details = 1
        case actions = 2
        case links = 3
    }
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
        return sectionsNumber
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SectionNumbers(rawValue: section) {
        case .thumbnail:
            return 1
        case .details:
            return 1
        case .links:
            return 1
        default:
            return presenter.TableViewCellCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionNumbers(rawValue: indexPath.section) {
        case .thumbnail:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.thumbnailCell.rawValue, for: indexPath) as! CharacterThumbnailCell
            presenter.configure(cell, at: indexPath.row)
            
            return cell
        case .details:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.detailsCell.rawValue, for: indexPath) as! CharacterDetailsCell
            presenter.configure(cell, at: indexPath.row)
            
            return cell
        case .links:
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
        if SectionNumbers(rawValue: indexPath.section) == .actions {
            guard let cell = cell as? CharacterActionsCell else { return }
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            presenter.tableViewWillDisplayAt(cell, at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if SectionNumbers(rawValue: indexPath.section) == .actions {
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectAt(parentRow: collectionView.tag, childRow: indexPath.row)
    }
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
    
    func setupPresentation() {
        definesPresentationContext = true
    }
    
    func configureLinksStackViewsWith(title: String) -> UIStackView {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.contentHorizontalAlignment = .left;
        let arrow = UIImageView(image: UIImage(named: "icn-cell-disclosure"))
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(arrow)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func presentMediaDataWith(data: ActionsResponse.Data.Results) {
        let imageViewerVC = returnViewControllerWith("imageViewerVC", in: MAIN_STORYBOARD, type: ImageViewerViewController.self)
        imageViewerVC.mediaData = data
        imageViewerVC.modalPresentationStyle = .overCurrentContext
        present(imageViewerVC, animated: false, completion: nil)
    }
}
