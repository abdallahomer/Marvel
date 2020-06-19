//
//  Indicator.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation
import UIKit

class Indicator {
    static var activityIndicator = UIActivityIndicatorView()

    static func showLoading() {
        if  let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window {
            activityIndicator.frame = CGRect(x:0, y:0, width:40, height:40)
            activityIndicator.style = .large
            activityIndicator.color = .red
            activityIndicator.center = CGPoint(x: window.bounds.width / 2, y: window.bounds.height / 2)
            window.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }

    static func hideLoading() {
        activityIndicator.stopAnimating()
    }
}
