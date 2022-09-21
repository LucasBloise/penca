//
//  UICollectionView+Utils.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import UIKit

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
    //swiftlint:disable force_cast
    func dequeueCell<T: UICollectionViewCell>(_ cellType: T.Type, forIndexPath indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        let nib = UINib(nibName: cellType.reuseIdentifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(_ viewType: T.Type, supplementaryViewKind: String) {
        let identifier = String(describing: viewType)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: supplementaryViewKind, withReuseIdentifier: identifier)
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(_ viewType: T.Type, for indexPath: IndexPath, supplementaryViewKind: String) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: supplementaryViewKind, withReuseIdentifier: String(describing: viewType), for: indexPath) as! T
    }
}
