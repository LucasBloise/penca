//
//  UIView+Utils.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat, corners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner,
                                                                .layerMaxXMinYCorner, .layerMaxXMaxYCorner]) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
        self.layer.masksToBounds = true
    }
    
    func addBorder(color: UIColor, width: CGFloat = 1) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func showLoader(isUserInteractionEnabled: Bool = false) -> UIActivityIndicatorView {
        if let loader = self.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
            return loader
        } else {
            let activityView = UIActivityIndicatorView(style: .medium)
            activityView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(activityView)
            activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            activityView.startAnimating()
            
            self.isUserInteractionEnabled = isUserInteractionEnabled
            return activityView
        }
    }
    
    func hideLoader(_ loader: UIActivityIndicatorView?) {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = true
            loader?.stopAnimating()
            loader?.removeFromSuperview()
        }
    }
}
