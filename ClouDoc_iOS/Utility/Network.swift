//
//  Network.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import Foundation
import Alamofire
import RxSwift

class Network {
    private init() {}
    
    static let `defalut` = Network()

    fileprivate var configuration:URLSessionConfiguration = {
        let c = URLSessionConfiguration.af.init(.ephemeral).type
        c.headers.add(.userAgent("Net-ID Browser"))
        c.waitsForConnectivity = true
        return c
    }()
    lazy var session = Session(configuration: self.configuration)
    
    
    func requestAll(_ requests:Single<[String:String]>...) -> Single<[[String : String]]> {
        var resultDict:[Int:[String:String]] = [:]
        var errorObj:Error?        
        
        return Single<[[String:String]]>.create { observer in 
            requests.enumerated().forEach { index, single in
                if let error = errorObj { return observer(.failure(error)) }
                single.subscribe(onSuccess: {
                    resultDict.updateValue($0, forKey: index)
                    
                    if resultDict.keys.count == requests.count {
                        let sortedKeys = resultDict.keys.sorted()
                        var resultArr:[[String : String]] = []
                        sortedKeys.forEach { resultArr.insert(resultDict[$0]!, at: $0) }
                        observer(.success(resultArr))
                    } 
                }, onFailure: { errorObj = $0 })
            }
            
            return Disposables.create()
        }
    }
    
    func request(url:String, parameter:[String:String] = [:], cookie:[String:String] = [:]) -> Single<[String:String]> {    
        return Single<[String:String]>.create { single in
            let headers:[String:String] = [
                "Connection":"close",
                "Content-Type":"application/x-www-form-urlencoded"
            ]
            
            let d = try? JSONSerialization.data(withJSONObject: parameter, options: [])
            self.session.request(url, method: .post, headers: HTTPHeaders(headers))
            { urlRequest in urlRequest.httpBody =  d}
            .responseData { response in
                switch response.result {
                case .success(let data):
                    
                    if response.response?.statusCode != 200 {
                        guard let body = String(data: data, encoding: String.Encoding.utf8),
                              let startRange = body.range(of: "<title>"),
                              let endRange = body.range(of: "</title>") else {
                                  //                                  throw NetworkError.NotExistResponeData
                                  let ee = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"!@!@!"])
                                  return single(.failure(ee))
                              } 
                        let ErrorDescription = body[startRange.upperBound..<endRange.lowerBound].components(separatedBy: " ")
                        let ee = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:ErrorDescription[1..<ErrorDescription.count].joined()])
                        return single(.failure(ee))
                    }
          
                    let responseString = String(data: data, encoding: .utf8)!
                    let split = responseString.split(separator: "\r\n",maxSplits: 2)
                    if split.count < 2 { 
                        let ee = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:split[1]]) 
                        return single(.failure(ee)) 
                    }
                    let z1 = split[2].split(separator: "\r\n").map{ ss -> (String, String) in  
                        let s = String(ss).split(separator: "\t").map{String($0)}
                        return (s[0], s[safe:1] ?? "")    
                    }
                    let dd = Dictionary(uniqueKeysWithValues: z1)
                
                    single(.success(dd))
                case .failure(let error):
                    single(.failure(error))
                    return 
                }
            }    
            return Disposables.create()   
        }
    }
    
    func request(url:String, parameter:[String:String] = [:], cookie:[String:String] = [:]) -> Observable<[String:String]> {    
        return Observable.create { observer in
            let headers:[String:String] = [
                "Connection":"close",
                "Content-Type":"application/x-www-form-urlencoded"
            ]
            
            let d = try? JSONSerialization.data(withJSONObject: parameter, options: [])
            self.session.request(url, method: .post, headers: HTTPHeaders(headers))
            { urlRequest in urlRequest.httpBody =  d}
            .responseData {  response in
                switch response.result {
                case .success(let data):
                    
                    if response.response?.statusCode != 200 {
                        guard let body = String(data: data, encoding: String.Encoding.utf8),
                              let startRange = body.range(of: "<title>"),
                              let endRange = body.range(of: "</title>") else {
                                  //                                  throw NetworkError.NotExistResponeData
                                  let ee = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"!@!@!"])
                                  return observer.onError(ee)
                              } 
                        let ErrorDescription = body[startRange.upperBound..<endRange.lowerBound].components(separatedBy: " ")
                        let ee = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:ErrorDescription[1..<ErrorDescription.count].joined()])
                        return observer.onError(ee)
                    }
          
                    let responseString = String(data: data, encoding: .utf8)!
                    let split = responseString.split(separator: "\r\n",maxSplits: 2)
                    if split.count < 2 { 
                        let ee = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:split[1]]) 
                        return observer.onError(ee) 
                    }
                    let z1 = split[2].split(separator: "\r\n").map{ ss -> (String, String) in  
                        let s = String(ss).split(separator: "\t").map{String($0)}
                        return (s[0], s[safe:1] ?? "")    
                    }
                    let dd = Dictionary(uniqueKeysWithValues: z1)
                
                    observer.onNext(dd)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                    return 
                }
            }    
            return Disposables.create()   
        }
    }
}
