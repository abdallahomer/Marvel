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
}

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var characterData: CharacterResponse.Data.Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviationItems()
    }
}

extension CharacterDetailsViewController {
    func setupNaviationItems() {
        title = characterData?.name
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: -88,left: 0,bottom: 0,right: 0);

    }
}

extension CharacterDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "thumbnailCell", for: indexPath) as! CharacterThumbnailCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! CharacterDetailsCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "actionsCell", for: indexPath) as! CharacterActionsCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "relatedLinksCell", for: indexPath) as! CharacterRelatedLinksCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension CharacterDetailsViewController: UITableViewDelegate {
    
}
