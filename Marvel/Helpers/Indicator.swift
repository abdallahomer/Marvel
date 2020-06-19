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
    static var overlayView = UIView()
    static var activityIndicator = UIActivityIndicatorView()

    static func showLoading() {
        if  let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window {
            overlayView.frame = CGRect(x:0, y:0, width:80, height:80)
            overlayView.center = CGPoint(x: window.frame.width / 2.0, y: window.frame.height / 2.0)
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            overlayView.clipsToBounds = true
            overlayView.layer.cornerRadius = 10
            activityIndicator.frame = CGRect(x:0, y:0, width:40, height:40)
            activityIndicator.style = .large
            activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
            overlayView.addSubview(activityIndicator)
            window.addSubview(overlayView)
            activityIndicator.startAnimating()
        }
    }

    static func hideLoading() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
