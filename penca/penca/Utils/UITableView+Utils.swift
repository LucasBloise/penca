//
//  UITableView+Utils.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import UIKit

protocol ReusableView: AnyObject { }

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}

extension UITableView {
    // swiftlint:disable force_cast
    func dequeueCell<T: UITableViewCell>(_ cellType: T.Type, forIndexPath indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as! T
    }
    
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        
        let nib = UINib(nibName: cellType.reuseIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
 
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type) {
        let nib = UINib(nibName: viewType.reuseIdentifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
    }
}
