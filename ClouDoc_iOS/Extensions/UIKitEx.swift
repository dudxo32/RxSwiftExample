//
//  UIKitEx.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/17.
//

import UIKit

extension UIViewController {
   var safeView:UIView {
        //get 방식을 통해 읽기전용으로 safeView 구현
        get{
            guard let safeView = self.view.viewWithTag(Int(INT_MAX)) else {
                let view = UIView().then {
                	$0.tag = Int(INT_MAX) 
                }
                
                self.view.addSubview(view)
                view.snp.makeConstraints {
                    $0.edges.equalTo(self.view.safeAreaLayoutGuide)
                }
                return view
            }
            return safeView
        }
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
