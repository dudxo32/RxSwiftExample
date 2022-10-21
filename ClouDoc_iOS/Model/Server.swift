//
//  Server.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import Foundation

struct Server {
    var ip:String {
        get{
            return UserDefaults.standard.string(forKey: "IP") ?? ""
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "IP")
        }
    }
    var port:String {
        get{
            return  UserDefaults.standard.string(forKey: "port") ?? "80"
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "port")
        }
    }
    var securePort:String {
        get{
            return UserDefaults.standard.string(forKey: "securePort") ?? "443"
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "securePort")
        }
    }
    
    var isUseExternal:Bool {
        get{
            return UserDefaults.standard.bool(forKey: "isUseExternal")
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "isUseExternal")
        }
    }
    var externalIP:String {
        get{
            return UserDefaults.standard.string(forKey: "externalIP") ?? ""
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "externalIP")
        }
    }
    var externalPort:String {
        get{
            return UserDefaults.standard.string(forKey: "externalPort") ?? "80"
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "externalPort")
        }
    }
}
