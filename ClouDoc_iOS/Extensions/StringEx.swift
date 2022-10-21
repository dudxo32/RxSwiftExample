//
//  StringEx.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/17.
//

import Foundation

extension String {
    // For I18NString
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
