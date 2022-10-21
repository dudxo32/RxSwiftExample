//
//  LoginViewController.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    private let loginVM = LoginViewModel()
    private let disposeBag = DisposeBag()
                let l = LoginSettingViewController()

    private lazy var marginHorizontal = self.view.safeAreaLayoutGuide.layoutFrame.width * 0.13
    private lazy var logo = UIImageView().then {
        $0.image = UIImage(named: "logo_blue")
    }   
    
    private lazy var inputID = UITextField().then {
            $0.leftViewMode = .always
            $0.layer.borderColor = UIColor.disable.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 5
            $0.textColor = UIColor.main
            $0.placeholder = I18N.insertId
            $0.text = UserDefaults.standard.string(forKey: "userID") ?? ""
        }
    private lazy var inputPassword = UITextField().then {
            $0.leftViewMode = .always
            $0.layer.borderColor = UIColor.disable.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 5
            $0.textColor = UIColor.main
            $0.isSecureTextEntry = true
            $0.placeholder = I18N.insertPassword
        }
    private lazy var loginButton = UIButton().then {
        $0.layer.cornerRadius = 5
        $0.setBackgroundColor(color: UIColor.disable, forState: .disabled)
        $0.setBackgroundColor(color: UIColor.main, forState: .normal)
        $0.tintColor = UIColor.white
        $0.setTitle(I18N.login, for: .normal)
    }
    private lazy var settingButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "setting"), for:.normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.addSubViews()
        self.setContraints()
        
        self.inputBind()
        self.outputBind()
    }
    
    private func addSubViews() {
        self.view.addSubview(self.logo)
        self.view.addSubview(self.inputID)
        self.view.addSubview(self.inputPassword)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.settingButton)
    }
    
    private func setContraints() {
        self.logo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(250)
            $0.centerX.equalToSuperview()
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(self.marginHorizontal)
            let h = (self.view.safeAreaLayoutGuide.layoutFrame.width - (self.marginHorizontal * 2))/3
            $0.height.equalTo(h)
        }
        
        self.inputID.snp.makeConstraints { 
            $0.top.equalTo(self.logo.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(self.marginHorizontal)
            $0.height.equalTo(55)
        }
        
        self.inputPassword.snp.makeConstraints { 
            $0.top.equalTo(self.inputID.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(self.marginHorizontal)
            $0.height.equalTo(55)
        }
        
        self.loginButton.snp.makeConstraints {
            $0.top.equalTo(self.inputPassword.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(self.marginHorizontal)
            $0.height.equalTo(60)
        }
        
        self.settingButton.snp.makeConstraints {
            $0.right.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(25)
            $0.width.height.equalTo(30)
        }
    }
    
    private func inputBind() {
        self.inputID.rx.controlEvent(.editingDidBegin)
            .map{UIControl.Event.editingDidBegin}
            .bind(to:self.loginVM.input.idEditEvent)
            .disposed(by: self.disposeBag)
        self.inputID.rx.controlEvent(.editingDidEnd)
            .map{UIControl.Event.editingDidEnd}
            .bind(to:self.loginVM.input.idEditEvent)
            .disposed(by: self.disposeBag)
        
        self.inputID.rx.text.orEmpty
            .bind(to: self.loginVM.input.userID)
            .disposed(by: self.disposeBag)
        
        self.inputPassword.rx.controlEvent(.editingDidBegin)
            .map{UIControl.Event.editingDidBegin}
            .bind(to:self.loginVM.input.passwordEditEvent)
            .disposed(by: self.disposeBag)
        self.inputPassword.rx.controlEvent(.editingDidEnd)
            .map{UIControl.Event.editingDidEnd}
            .bind(to:self.loginVM.input.passwordEditEvent)
            .disposed(by: self.disposeBag)
        
        self.inputPassword.rx.text.orEmpty
            .bind(to: self.loginVM.input.password)
            .disposed(by: self.disposeBag)
        
        self.loginButton.rx.tap
            .bind(to: self.loginVM.input.loginTap)
            .disposed(by: self.disposeBag)
            
        self.settingButton.rx.tap
        .asSignal()
        .emit { _ in
            let a = LoginSettingViewController()
            self.navigationController?.pushViewController(a, animated: true)
        }
        .disposed(by: self.disposeBag) 
    }
    
    private func outputBind() {
        self.loginVM.output.changeIdFieldStatus
            .asDriver()
            .drive { (view:UIView, color:CGColor) in
                self.inputID.leftView = view
                self.inputID.layer.borderColor = color
            }
            .disposed(by:self.disposeBag)
        
        self.loginVM.output.changePasswordFieldStatus
            .asDriver()
            .drive { (view:UIView, color:CGColor) in
                self.inputPassword.leftView = view
                self.inputPassword.layer.borderColor = color
            }
            .disposed(by:self.disposeBag)

        self.loginVM.output.setLoginButtonEnable
            .asDriver()
            .drive(self.loginButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
                  
//        self.loginVM.output.ID.asDriver().drive(self.inputID.rx.text)
        
        
    }
}
