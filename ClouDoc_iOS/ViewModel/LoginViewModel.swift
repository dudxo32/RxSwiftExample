//
//  LoginViewModel.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewModel: ViewModelProtocol {
    enum Result {}
    enum ErrorType {}
    struct Input {
        let idEditEvent = BehaviorRelay<(UIControl.Event)>(value: .editingDidEnd)
        let passwordEditEvent = BehaviorRelay<UIControl.Event>(value: .editingDidEnd)
        let userID = PublishRelay<String>()
        let password = PublishRelay<String>()
        let loginTap = PublishRelay<Void>()
        let settingTap = PublishRelay<Void>()
    }
    struct Output {
        let changeIdFieldStatus = BehaviorRelay<(UIView, CGColor)>(value: ( UIView(), UIColor.disable.cgColor))
        let changePasswordFieldStatus = BehaviorRelay<(UIView, CGColor)>(value: (  UIView(), UIColor.disable.cgColor))
        let setLoginButtonEnable = BehaviorRelay<Bool>(value: false) 
        //        var changeIdFieldStatus = PublishRelay<(UIView, CGColor)>().init(value: ( UIView(), UIColor.disalbe.cgColor))
    }
    
    let disposeBag = DisposeBag()
    var input:Input
    var output:Output
    
    init() {
        self.input = Input()
        self.output = Output()
        
        self.outputBind()   
    }
    
    private func outputBind() {
        
        // Set ID InputTextField
        Observable.combineLatest(self.input.idEditEvent, self.input.userID)
            .map { (event, userID) in
                return self.setInputFieldStatus(event: event, str: userID,
                                                onImage: UIImage(named: "person_blue"),
                                                offImage: UIImage(named: "person_grey"))  
            }
            .bind(to: self.output.changeIdFieldStatus)
            .disposed(by: self.disposeBag)
        
        // Set Password InputTextField 
        Observable.combineLatest(self.input.passwordEditEvent, self.input.password)
            .map { (event, password) in
                return self.setInputFieldStatus(event: event, str: password,
                                                onImage: UIImage(named: "lock_blue"),
                                                offImage: UIImage(named: "lock_grey"))
            }
            .bind(to: self.output.changePasswordFieldStatus)
            .disposed(by: self.disposeBag)
        
        // Set LoginButton enable
        Observable.combineLatest(self.input.userID, self.input.password)
            .map { id, password in
                return (id.count != 0 && password.count != 0)
            }
            .bind(to: self.output.setLoginButtonEnable)
            .disposed(by: self.disposeBag)
            
        // Tap LoginButton
        self.input.loginTap
            .withLatestFrom(Observable.combineLatest(self.input.userID, self.input.password))
            .bind{ (id, password) in
                UserDefaults.standard.set(id, forKey: "userID")
            }
            .disposed(by: self.disposeBag)
            
            // Tap SettingButton
    }
    
    private func setInputFieldStatus(event:UIControl.Event, str:String, onImage:UIImage?, offImage:UIImage?) -> (UIView, CGColor) {
        let leftViewSize = 55.0
        let imageSize = 25.0
        
        let isEditBegin = event == .editingDidBegin
        let valueIsEmpty = str.count <= 0
        let image = isEditBegin ? onImage : valueIsEmpty ? offImage : onImage
        let borderColor = isEditBegin ? UIColor.main : valueIsEmpty ? UIColor.disable : UIColor.main  
        
        let imageView = UIImageView(frame: CGRect(x: (leftViewSize-imageSize)/2, y: (leftViewSize-imageSize)/2, width: imageSize, height: imageSize))
        imageView.image =  image
        imageView.contentMode = .scaleAspectFit
        
        let leftView = UIView(frame:  CGRect(x: 0, y: 0, width: leftViewSize, height: leftViewSize) )
        leftView.addSubview(imageView)
        
        return (leftView, borderColor.cgColor)
    }
}
