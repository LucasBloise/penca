//
//  UIViewController+Utils.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import UIKit

extension UIViewController {
    func showLoader(isUserInteractionEnabled: Bool = false) -> UIActivityIndicatorView {
        view.showLoader(isUserInteractionEnabled: isUserInteractionEnabled)
    }
    
    func hideLoader(_ loader: UIActivityIndicatorView?) {
        view.hideLoader(loader)
    }
    
    func presentError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}
