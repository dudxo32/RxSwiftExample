//
//  SettingTableViewModel.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/24.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class SettingTableViewModel:ViewModelProtocol {
    enum Result { }
    enum ErrorType{ }
    
    struct Input {
    	let tapTableCell = PublishRelay<SettingItem>()
    }
    struct Output {}
 
    
    var input: Input
    var output: Output
    let bag = DisposeBag()
    init() {
        self.input = Input()
        self.output = Output()
        
        self.input.tapTableCell
            .bind(onNext: self.callUIEvent)
            .disposed(by: self.bag)
    }
    
    private func callUIEvent(item:SettingItem) {
        if let button = item.valueUI as? UIButton {
            button.sendActions(for: .touchUpInside)
        } else if let `switch` = item.valueUI as? UISwitch {
            `switch`.setOn(!`switch`.isOn, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) { 
                `switch`.sendActions(for: .valueChanged)
            }
        } else if let input = item.valueUI as? UITextInput {
   
        }
    }
}
