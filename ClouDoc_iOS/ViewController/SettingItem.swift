//
//  SettingItemModel.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/22.
//

import Foundation
import RxDataSources

struct SettingItem {
    var title:String
    var valueUI:UIView
}

struct SectionOfSettingItem {
    var section:String
    var items:[Item]
}

extension SectionOfSettingItem: SectionModelType {
    typealias Item = SettingItem
    
    init(original: SectionOfSettingItem, items: [SettingItem]) {
        self = original
        self.items = items
    }
}
