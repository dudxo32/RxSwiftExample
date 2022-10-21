//
//  CollectionEx.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
  subscript (safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
