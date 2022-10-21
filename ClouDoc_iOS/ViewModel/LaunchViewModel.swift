//
//  LaunchViewModel.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import Foundation
import RxSwift

class LaunchViewModel:ViewModelProtocol {
    enum Result {}
    enum ErrorType {
    }
    struct Input {
        
    }
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    let disposeBag = DisposeBag()
    
    init() {
        self.input = Input()
        self.output = Output()
    }
    
    func getServerConf() -> Observable<ServerConf> {
        let para = ["OSLang":"kor", "User":"gdhong"]
        return Observable<ServerConf>.create { observer in
            Observable.combineLatest([
                Network.defalut.request(url: "http://192.168.1.57/clientsvc/GetServerInfo.jsp")
                    .map{ dict -> [String:String] in
                        var returnDict = [String:String]()
                        if let siteID = dict["SiteID"] {
                            returnDict.updateValue("SiteID", forKey: siteID)
                        }
                        
                        // Product version
                        if let pVersion = dict["ProductVersion"] {
                            returnDict.updateValue("ProductVersion", forKey: pVersion)
                            // 이건 컨프? userdefault?
                        }
                        
                        if let configs = dict["nClientConfigs"] {                
                            let nClient2 = Int(configs.split(separator: ",")[2]) ?? 0 	
                            
                            /* Personal Info Detection */
                            returnDict.updateValue((nClient2 & 0x00002000) > 0 ? "yes" : "no", forKey: ServerConf.CodingKeys.usePersonalInfo.rawValue)
                            returnDict.updateValue((nClient2 & 0x00000400) > 0 ? "yes" : "no", forKey: ServerConf.CodingKeys.useDocLink.rawValue)
                            returnDict.updateValue((nClient2 & 0x00000800) > 0 ? "yes" : "no", forKey: ServerConf.CodingKeys.useSecureDocLink.rawValue)
                            returnDict.updateValue((nClient2 & 0x01000000) > 0 ? "yes" : "no", forKey: ServerConf.CodingKeys.useChangePassword.rawValue)
                        }
                        
                        return returnDict
                    },
                Network.defalut.request(url: "http://192.168.1.57:80/webapp/GetTabletInfo.jsp", parameter: para)
            ], resultSelector:{ arr -> [String:String] in
                var mergeDict = arr.first ?? [:]
                mergeDict.merge(arr[1]) { first, _ in return first }
                return mergeDict
            }).subscribe { event in
                switch event {
                case .next(let dic):
                    let jsonData = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                    let json = try! JSONDecoder().decode(ServerConf.self, from: jsonData)
                    observer.onNext(json)
                case .error(_):
                    break
                case .completed:
                    break
                }
            }.disposed(by: self.disposeBag)  
            
            return Disposables.create()
        } 
        
    }
}
