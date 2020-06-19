//
//  CharactersViewController.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

protocol CharactersViewLogic: IndicatorProtocol {
    
}

class CharactersViewController: UIViewController {
    private let charactersCellIdentifier = "charactersCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: charactersCellIdentifier, for: indexPath)
        return cell
    }
}

extension CharactersViewController: UITableViewDelegate {
    
}
