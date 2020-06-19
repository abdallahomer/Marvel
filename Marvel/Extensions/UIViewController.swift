//
//  UIViewController.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func pushViewControllerWith<T: UIViewController>(_ identifier: String, in storyboard: String, type: T.Type? = nil) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentViewControllerWith<T: UIViewController>(_ identifier: String, in storyboard: String, type: T.Type? = nil) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        present(viewController, animated: false, completion: nil)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIViewController: IndicatorProtocol {
    func showIndicator() {
        Indicator.showLoading()
    }
    
    func hideIndicator() {
        Indicator.hideLoading()
    }
}
