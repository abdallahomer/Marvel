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
    func pushViewControllerWith(_ identifier: String, in storyboard: String) {
        let viewController = setupViewControllerWith(identifier, in: storyboard)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentViewControllerWith<T: UIViewController>(_ identifier: String, in storyboard: String, type: T.Type? = nil) {
        let viewController = setupViewControllerWith(identifier, in: storyboard)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false, completion: nil)
    }
    
    func returnViewControllerWith<T: UIViewController>(_ identifier: String, in storyboard: String, type: T.Type? = nil) -> T {
        let viewController = setupViewControllerWith(identifier, in: storyboard, type: type)
        return viewController
    }
    
    private func setupViewControllerWith<T: UIViewController>(_ identifier: String, in storyboard: String, type: T.Type? = nil) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        return viewController
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
