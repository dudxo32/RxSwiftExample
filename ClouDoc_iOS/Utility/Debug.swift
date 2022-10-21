//
//  Debug.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import Foundation

class Debug: NSObject {
  static func log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcName: String = #function) { 
    #if DEBUG 
    let th = Thread.current.isMainThread ? "main": Thread.current.name ?? "No thread Name"
    if let obj = object { 
      print("*LOG* \(obj) :: \(filename.components(separatedBy: "/").last ?? "") (LINE:\(line)) :: \(funcName) :: \(th) ") 
    } else {
      print("*LOG* nil :: \(filename.components(separatedBy: "/").last ?? "") (LINE:\(line)) :: \(funcName)) :: \(th) ")
    } 
    #endif 
  }
}
