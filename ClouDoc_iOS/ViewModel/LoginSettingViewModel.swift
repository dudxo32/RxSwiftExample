//
//  LoginSettingViewModel.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/24.
//

import Foundation
import RxRelay

class LoginSettingViewModel: ViewModelProtocol {
    enum Result {}
    
    enum ErrorType {}
    
    struct Input {
    	let buttonTap = PublishRelay<Void>()
        let switchTap = PublishRelay<Bool>()   
    }
    
    struct Output {
    	let tapOut = PublishRelay<String>()
    }
    
    let input: Input
    let output: Output
    
    init() {
        self.input = Input()
        self.output = Output()
        
        self.input.buttonTap.map{"button"}.bind(to: self.output.tapOut)
        self.input.switchTap.map{ $0 ? "switch t" : "switch f"}.bind(to: self.output.tapOut)
        
        
//        .bind(to:self.output.tapOut)
    }
    
    
}
