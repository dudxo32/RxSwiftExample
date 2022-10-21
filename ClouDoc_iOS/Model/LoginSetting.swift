//
//  LoginSetting.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import Foundation

struct LoginSetting {
    var loginType:Bool {
        get{
            UserDefaults.standard.bool(forKey: "loginType")
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "loginType")
        }
    }
     var useAutoLogin:Bool {
        get{
            UserDefaults.standard.bool(forKey: "autoLogin")
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "autoLogin")
        }
    }
     var useSSL:Bool {
        get{
            UserDefaults.standard.bool(forKey: "externalServer")
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "externalProt")
        }
    }
}
