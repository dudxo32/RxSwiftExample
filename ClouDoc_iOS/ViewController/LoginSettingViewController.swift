//
//  LoginSettingViewController.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/17.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxDataSources

class LoginSettingViewController: UIViewController {
    let bag = DisposeBag()
    let LoginSettingVM = LoginSettingViewModel()
    
    let b = UIButton().then { 
        $0.layer.borderWidth = 1
        $0.setTitle("온라인", for: .normal)
        $0.setTitleColor(.black, for: .normal)   
        $0.contentHorizontalAlignment = .right
    }
    
    let b1 = UIButton().then { 
        $0.layer.borderWidth = 1   
        $0.setTitle("온라eeeeeeweweweweweweeweeweweew인", for: .normal)
        $0.setTitleColor(.black, for: .normal)   
        $0.contentHorizontalAlignment = .right
    }
    
    let u = UISwitch().then {
        $0.onTintColor = .main
    }
    
    let tt = UITextField().then { 
        $0.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        $0.layer.borderWidth = 1
        $0.textAlignment = .right
    }
      let tt1 = UITextField().then { 
        $0.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        $0.layer.borderWidth = 1
        $0.textAlignment = .right
    }
    
    lazy var sections = [
        SectionOfSettingItem(section: "서버정보", items: [SettingItem(title: "12222222222", valueUI: b1)]),
        
        SectionOfSettingItem(section: "서버정보1", items: [SettingItem(title: "21", valueUI: tt1)]),
        SectionOfSettingItem(section: "서버정보1", items: [SettingItem(title: "21", valueUI: u)]),
        SectionOfSettingItem(section: "서버정보1", items: [SettingItem(title: "21", valueUI: tt),SettingItem(title: "21", valueUI: tt),SettingItem(title: "21", valueUI: tt),SettingItem(title: "21", valueUI: tt),SettingItem(title: "21", valueUI: tt),SettingItem(title: "21", valueUI: tt),SettingItem(title: "21", valueUI: tt),SettingItem(title: "21", valueUI: tt),SettingItem(title: "21", valueUI: tt)]),
        
    ]
    lazy var tableView = SettingTableView(sections: sections)
    
    override func viewDidLoad() {
//        RxKeyboard.instance.visibleHeight.drive (onNext:{ keyboardHeight in
//            let height = keyboardHeight > 0 ? -keyboardHeight + self.view.safeAreaInsets.bottom : 0
//            self.tt.snp.updateConstraints{
//                $0.bottom.equalTo(self.safeView.snp.bottom) //.offset-height)               
//            }
//            self.view.layoutIfNeeded()
//        })
        
        self.navigationItem.title = I18N.loginSetting
        self.view.backgroundColor = UIColor.systemBackground
        self.safeView.backgroundColor = UIColor.background

        self.addSubViews()
        self.setContraints()
//        tableView.rx.didScroll.bind {  in
//            
//        }
//        self.tt.
        self.b1.rx.tap
            .bind(to: LoginSettingVM.input.buttonTap)
            .disposed(by: self.bag)
        //        self.tableView.setItems(sections: sections)
        
        self.u.rx.controlEvent(.valueChanged)
            .map{self.u.isOn}
            .bind(to: LoginSettingVM.input.switchTap)
            .disposed(by: self.bag)
      
         
        self.LoginSettingVM.output.tapOut.bind { s in
            Debug.log("result: \(s)")
        }.disposed(by: self.bag)
    }
    
    private func addSubViews() {
        self.safeView.addSubview(self.tableView)   
    }
    
    private func setContraints() {
        self.tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
    }
}

