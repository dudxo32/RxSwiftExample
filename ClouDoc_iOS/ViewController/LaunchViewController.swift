//
//  ViewController.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class LaunchViewController: UIViewController {
    private let launchVM = LaunchViewModel()
    private lazy var logoImageView = UIImageView().with {
        $0.image = UIImage(named: "logo_white")
    }
    private lazy var backgroundView = UIView().with {
        $0.backgroundColor = UIColor.main
    }
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        
        self.view.addSubview(self.backgroundView)	
        self.backgroundView.addSubview(self.logoImageView)
        
        self.backgroundView.snp.makeConstraints {
            $0.width.height.edges.equalToSuperview()
        }
        
        self.logoImageView.snp.makeConstraints {
            let w = self.view.frame.size.width * 0.7
            $0.width.equalTo(w)
            $0.height.equalTo(w/3)
            $0.center.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.launchVM.getServerConf()
//            .asDriver(onErrorJustReturn: ServerConf())
//            .drive { serverConf in
//                Debug.log(serverConf)
//                let loginVC = LoginViewController()
//                let navVC = UINavigationController(rootViewController: loginVC)
//                navVC.navigationBar.topItem?.title = ""
//                navVC.navigationBar.tintColor = .gray
//                navVC.modalPresentationStyle = .fullScreen
//                navVC.modalTransitionStyle = .crossDissolve
//                self.present(navVC, animated: true)
//            }
//            .disposed(by: self.disposeBag)
        let loginVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: loginVC)
        navVC.navigationBar.topItem?.title = ""
        navVC.navigationBar.tintColor = .gray
        navVC.modalPresentationStyle = .fullScreen
        navVC.modalTransitionStyle = .crossDissolve
        self.present(navVC, animated: true)
    }
}

