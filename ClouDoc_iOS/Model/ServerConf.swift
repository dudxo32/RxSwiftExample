//
//  ServerConf.swift
//  ClouDoc_iOS
//
//  Created by mac on 2022/02/16.
//

import Foundation

struct ServerConf {
    let copyRight:String
    let fileOpen:String
    let exportFileOpen:String
    let useLocalDisk:String
    let useMobileTree:String
    let useCamera:String
    let docLang:String
    let savePassword:String
    let useDocExport:String
    let useExternalStorage:String
    let useMqtt:String
    let pushServerPort:String
    let pushServerUrl:String
    let maxUseTerm:String
    let viewDownloadUrl:String
    let useSslLogin:String
    let useAnnotViewer:String
    let useAutoLogin:String
    let registerApprovedType:String
    let usePreventCapture:String
    let useSolr:String
    let useSecureLevel:String
    let useDocLink:String
    let useSecureDocLink:String
    let usePersonalInfo:String
    let useChangePassword:String

   init() {
        self.copyRight = ""
        self.fileOpen = ""
        self.exportFileOpen = ""
        self.useLocalDisk = ""
        self.useMobileTree = ""
        self.useCamera = ""
        self.docLang = ""
        self.savePassword = ""
        self.useDocExport = ""
        self.useExternalStorage = ""
        self.useMqtt = ""
        self.pushServerPort = ""
        self.pushServerUrl = ""
        self.maxUseTerm = ""
        self.viewDownloadUrl = ""
        self.useSslLogin = ""
        self.useAnnotViewer = ""
        self.useAutoLogin = ""
        self.registerApprovedType = ""
        self.usePreventCapture = ""
        self.useSolr = ""
        self.useSecureLevel = ""
        self.useDocLink = ""
        self.useSecureDocLink = ""
        self.usePersonalInfo = ""
        self.useChangePassword = ""
    }

//    let appVersion: String
//    var useSSL: Bool
//    let autoLogin: Bool
//    let useData: Bool
//    let copyRight: String
//    let twoStepAuthServerName: String
//    let twoStepAuthServerPort: String
//    let usePreventCapture: Bool
//    let fileDownloadUrl: String
//    let useDocLink: Bool
//    let useSecureDocLink: Bool
//    let docLang: String
//    let exportFileOpen: String
//    let fileOpen: String
//    let maxUseTerm: Bool
//    let pushServerPort: String
//    let pushServerUrl: String
//    let registerApprovedType: String
//    let savePassword: String
//    let useAnnotViewer: Bool
//    let useAutoLogin: Bool
//    let useCamera: Bool
//    let useDocExport: Bool
//    let useExternalStorage: Bool
//    let useLinkMail: Bool
//    let useLocalDisk: Bool
//    let useMobileTree: Bool
//    let useMqtt: Bool
//    let useSecureLevel: Bool
//    let useSolr: Bool
//    let useSslLogin: Bool
//    let useWeblink: Bool
//    let viewDownloadUrl: String
//    let pollingPeriod: String
//    let useUpload: Bool
//    let useCreateFolder: Bool
//    let usePersonalInfo: Bool
//    let useChangePassword: Bool
    
    /*
     use_secure_weblink_approve: string
     let default_use_term: String
     use_weblink_copy: string
     use_secure_weblink_copy: string
     use_proxy_weblink_copy: string
     use_weblink_sendmail: string
     use_secure_weblink_mail: string
     use_proxy_weblink_mail: string
     
     drm_export:
     | string
     | object
     | {
     // TODO: Declare keys
     }
     use_alarm:
     | string
     | object
     | {
     doc_export: string
     linkmail: string
     notice: string
     weblink: string
     }
     doc_export:
     | string
     | object
     | {
     ApproveType: string
     ApproverType: string
     Contents: string
     CustomApproveInfo: string
     ExpireDay: string
     ExpireType: string
     ExportDisk: string
     ExportSize: string
     ExportType: string
     Line: string
     Subject: string
     UseNpouch: string
     UseUSBCrypt: string
     Version: string
     export_disk_unused: string
     sentences_for_doc_export_request: string
     }
     
     */
    
    enum CodingKeys:String, CodingKey {
        case copyRight = "copyright"
        case fileOpen = "file_open"
        case exportFileOpen = "export_file_open"
        case useLocalDisk = "use_local_disk"
        case useMobileTree = "use_mobile_tree"
        case useCamera = "use_camera"
        case docLang = "doc_lang"
        case savePassword = "save_password"
        case useDocExport = "use_doc_export"
        case useExternalStorage = "use_external_storage"
        case useMqtt = "use_mqtt"
        case pushServerPort = "push_server_port"
        case pushServerUrl = "push_server_url"
        case maxUseTerm = "max_use_term"
        case viewDownloadUrl = "view_download_url"
        case useSslLogin = "use_ssl_login"
        case useAnnotViewer = "use_annot_viewer"
        case useAutoLogin = "use_auto_login"
        case registerApprovedType = "register_approved_type"
        case usePreventCapture = "use_prevent_capture"
        case useSolr = "use_solr"
        case useSecureLevel = "use_secure_level"
        case useDocLink = "use_doc_link"
        case useSecureDocLink = "use_secure_doc_link"
        case usePersonalInfo = "use_personal_info"
        case useChangePassword = "use_change_password"

        
//              case useLinkMail = "use_link_mail"
//        case useWeblink = "use_weblink"
//        
//        
//        
//        case appVersion = "app_version"
//        case useSSL = "useSSL"
//        case autoLogin = "autoLogin"
//        case useData = "useData"
//        
//        case twoStepAuthServerName = "two_step_auth_server_name"
//        case twoStepAuthServerPort = "two_step_auth_server_port"
//        case fileDownloadUrl = "file_download_url"
//        
//
//  
//        case pollingPeriod = "PollingPeriod"
//        case useUpload = "use_upload"
//        case useCreateFolder = "use_create_folder"
    }
}

extension ServerConf:Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ServerConf.CodingKeys.self)
        
        self.copyRight = (try? values.decode(String.self, forKey: .copyRight)) ?? ""
        self.fileOpen = (try? values.decode(String.self, forKey: .fileOpen)) ?? ""
        self.exportFileOpen = (try? values.decode(String.self, forKey: .exportFileOpen)) ?? ""
        self.useLocalDisk = (try? values.decode(String.self, forKey: .useLocalDisk)) ?? ""
        self.useMobileTree = (try? values.decode(String.self, forKey: .useMobileTree)) ?? ""
        self.useCamera = (try? values.decode(String.self, forKey: .useCamera)) ?? ""
        self.docLang = (try? values.decode(String.self, forKey: .docLang)) ?? ""
        self.savePassword = (try? values.decode(String.self, forKey: .savePassword)) ?? ""
        self.useDocExport = (try? values.decode(String.self, forKey: .useDocExport)) ?? ""
        self.useExternalStorage = (try? values.decode(String.self, forKey: .useExternalStorage)) ?? ""
        self.useMqtt = (try? values.decode(String.self, forKey: .useMqtt)) ?? ""
        self.pushServerPort = (try? values.decode(String.self, forKey: .pushServerPort)) ?? ""
        self.pushServerUrl = (try? values.decode(String.self, forKey: .pushServerUrl)) ?? ""
        self.maxUseTerm = (try? values.decode(String.self, forKey: .maxUseTerm)) ?? ""
        self.viewDownloadUrl = (try? values.decode(String.self, forKey: .viewDownloadUrl)) ?? ""
        self.useSslLogin = (try? values.decode(String.self, forKey: .useSslLogin)) ?? ""
        self.useAnnotViewer = (try? values.decode(String.self, forKey: .useAnnotViewer)) ?? ""
        self.useAutoLogin = (try? values.decode(String.self, forKey: .useAutoLogin)) ?? ""
        self.registerApprovedType = (try? values.decode(String.self, forKey: .registerApprovedType)) ?? ""
        self.usePreventCapture = (try? values.decode(String.self, forKey: .usePreventCapture)) ?? ""
        self.useSolr = (try? values.decode(String.self, forKey: .useSolr)) ?? ""
        self.useSecureLevel = (try? values.decode(String.self, forKey: .useSecureLevel)) ?? ""
        self.useDocLink = (try? values.decode(String.self, forKey: .useDocLink)) ?? ""
        self.useSecureDocLink = (try? values.decode(String.self, forKey: .useSecureDocLink)) ?? ""
        self.usePersonalInfo = (try? values.decode(String.self, forKey: .usePersonalInfo)) ?? ""
        self.useChangePassword = (try? values.decode(String.self, forKey: .useChangePassword)) ?? ""
//        self.appVersion = (try? values.decode(String.self, forKey: .appVersion)) ?? ""
//        self.useSSL = (try? values.decode(Bool.self, forKey: .useSSL)) ?? false
////        self.autoLogin = (try? values.decode(Bool.self, forKey: .autoLogin)) ?? ""
////        self.useData = (try? values.decode(Bool.self, forKey: .useData)) ?? ""
//        self.copyRight = (try? values.decode(String.self, forKey: .copyRight)) ?? ""
////        self.twoStepAuthServerName = (try? values.decode(String.self, forKey: .twoStepAuthServerName)) ?? ""
////        self.twoStepAuthServerPort = (try? values.decode(String.self, forKey: .twoStepAuthServerPort)) ?? ""
////        self.usePreventCapture = (try? values.decode(Bool.self, forKey: .usePreventCapture)) ?? ""
////        self.fileDownloadUrl = (try? values.decode(String.self, forKey: .fileDownloadUrl)) ?? ""
////        self.useDocLink = (try? values.decode(Bool.self, forKey: .useDocLink)) ?? ""
////        self.useSecureDocLink = (try? values.decode(Bool.self, forKey: .useSecureDocLink)) ?? ""
////        self.docLang = (try? values.decode(String.self, forKey: .docLang)) ?? ""
////        self.exportFileOpen = (try? values.decode(String.self, forKey: .exportFileOpen)) ?? ""
//        self.fileOpen = (try? values.decode(String.self, forKey: .fileOpen)) ?? ""
////        self.maxUseTerm = (try? values.decode(Bool.self, forKey: .maxUseTerm)) ?? ""
////        self.pushServerPort = (try? values.decode(String.self, forKey: .pushServerPort)) ?? ""
////        self.pushServerUrl = (try? values.decode(String.self, forKey: .pushServerUrl)) ?? ""
////        self.registerApprovedType = (try? values.decode(String.self, forKey: .registerApprovedType)) ?? ""
////        self.savePassword = (try? values.decode(String.self, forKey: .savePassword)) ?? ""
////        self.useAnnotViewer = (try? values.decode(Bool.self, forKey: .useAnnotViewer)) ?? ""
////        self.useAutoLogin = (try? values.decode(Bool.self, forKey: .useAutoLogin)) ?? ""
////        self.useCamera = (try? values.decode(Bool.self, forKey: .useCamera)) ?? ""
////        self.useDocExport = (try? values.decode(Bool.self, forKey: .useDocExport)) ?? ""
////        self.useExternalStorage = (try? values.decode(String.self, forKey: .useExternalStorage)) ?? ""
////        self.useLinkMail = (try? values.decode(String.self, forKey: .useLinkMail)) ?? ""
////        self.useLocalDisk = (try? values.decode(Bool.self, forKey: .useLocalDisk)) ?? ""
////        self.useMobileTree = (try? values.decode(Bool.self, forKey: .useMobileTree)) ?? ""
////        self.useMqtt = (try? values.decode(Bool.self, forKey: .useMqtt)) ?? ""
////        self.useSecureLevel = (try? values.decode(Bool.self, forKey: .useSecureLevel)) ?? ""
////        self.useSolr = (try? values.decode(Bool.self, forKey: .useSolr)) ?? ""
////        self.useSslLogin = (try? values.decode(Bool.self, forKey: .useSslLogin)) ?? ""
////        self.useWeblink = (try? values.decode(Bool.self, forKey: .useWeblink)) ?? ""
////        self.viewDownloadUrl = (try? values.decode(String.self, forKey: .viewDownloadUrl)) ?? ""
////        self.pollingPeriod = (try? values.decode(String.self, forKey: .pollingPeriod)) ?? ""
////        self.useUpload = (try? values.decode(Bool.self, forKey: .useUpload)) ?? ""
////        self.useCreateFolder = (try? values.decode(Bool.self, forKey: .useCreateFolder)) ?? ""
////        self.usePersonalInfo = (try? values.decode(Bool.self, forKey: .usePersonalInfo)) ?? ""
////        self.useChangePassword = (try? values.decode(Bool.self, forKey: .useChangePassword)) ?? ""
    }
}
