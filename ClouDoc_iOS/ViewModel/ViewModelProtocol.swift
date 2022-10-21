//
//  ViewModelProtocol.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Result
    associatedtype ErrorType
    associatedtype Input
    associatedtype Output
    var input: Input { get }
    var output: Output { get }
}
