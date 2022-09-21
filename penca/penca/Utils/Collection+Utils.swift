//
//  Collection+Utils.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
