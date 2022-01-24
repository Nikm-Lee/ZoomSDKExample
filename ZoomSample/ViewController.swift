//
//  ViewController.swift
//  ZoomSample
//
//  Created by esmnc1 on 2022/01/19.
//

import UIKit
import ZoomVideoSDK
import SwiftyJWT

private let SDKKey : String = "isct2jZPlNn7nn7nBNeLawX01b7IHOToipCI"
private let SDKSecretKey : String = "hiMtEEABUNq22H3JmQu6s2j0bWCUgMXzJe6f"

class ViewController: UIViewController, ZoomVideoSDKDelegate {
    var myJWT : JWT?
}

extension ViewController{
    private func pageInit(){
        ZoomVideoSDK.shareInstance()?.delegate = self
        joinSession()
    }
    
    private func joinSession(){
        let sessionContext = ZoomVideoSDKSessionContext()
        
        sessionContext.token = myJWT?.rawString
        sessionContext.sessionName = "e9mini"
        sessionContext.userName = "iPhoneSE2"
//        sessionContext.userName = "iPhone12Pro"
        sessionContext.sessionPassword = "aab"
//        let temp = ZoomVideoSDKVideoHelper()
//        ZoomVideoSDKVideoHelper().switchCamera()
        if let session = ZoomVideoSDK.shareInstance()?.joinSession(sessionContext){
            print("Session success")
            
        }
    }
    
    
    private func drawView(_ user : ZoomVideoSDKUser){
        
        if let usersVideoCanvas = user.getVideoCanvas(){
            let videoAspect = ZoomVideoSDKVideoAspect.panAndScan
            usersVideoCanvas.subscribe(with: view, andAspectMode: .full_Filled)
        }
    }
    
    private func stopView(_ user : ZoomVideoSDKUser){
        if let usersVideoCanvas = user.getVideoCanvas(){
            usersVideoCanvas.unSubscribe(with: view)
        }
    }
}

extension ViewController{
    
    func onUserJoin(_ helper: ZoomVideoSDKUserHelper!, users userArray: [ZoomVideoSDKUser]!) {
        print("onUser is Join")
        userArray.forEach{ print($0.getName()) }
        
        if let userArray = userArray {
            for user in userArray {
                print("joinUser : ",user.getName())
                drawView(user)
            }
        }
        
    }
    
    func onUserLeave(_ helper: ZoomVideoSDKUserHelper!, users userArray: [ZoomVideoSDKUser]!) {
        print("onUser is Leave")
        if let userArray = userArray {
            for user in userArray {
                print("leaveUser : ",user.getName())
                stopView(user)
            }
        }
    }
    
    func onSessionNeedPassword(_ completion: ((String?, Bool) -> ZoomVideoSDKERROR)!) {
        print("NeedCompletion \(completion)")
    }
    
    func onSessionPasswordWrong(_ completion: ((String?, Bool) -> ZoomVideoSDKERROR)!) {
        print("WrongCompletion \(completion)")
    }
    func onUserVideoStatusChanged(_ helper: ZoomVideoSDKVideoHelper!, user userArray: [ZoomVideoSDKUser]!) {
        print("onUserVideoStatus is Changed")
        if let userArray = userArray {
            for user in userArray {
                print("userVideoStatus is Changed : \(user.getName()) -> \(user.videoStatus().on)")
            }
        }
    }
    func onUserAudioStatusChanged(_ helper: ZoomVideoSDKAudioHelper!, user userArray: [ZoomVideoSDKUser]!) {
        print("userAudioStatus is Changed")
        if let userArray = userArray {
            for user in userArray {
                print("userAudioStatus is Changed : \(user.getName())")
            }
        }
    }
    func onLiveStreamStatusChanged(_ helper: ZoomVideoSDKLiveStreamHelper!, status: ZoomVideoSDKLiveStreamStatus) {
        switch status {
           case .inProgress:
               print("Live stream now in progress.")
        case .ended:
               print("Live stream has ended.")
           default:
               print("Live stream status unknown.")
           }
    }
    
}

//MARK: - CallBack

extension ViewController{
    
    func onError(_ ErrorType: ZoomVideoSDKERROR, detail details: Int) {
        switch ErrorType {
        case .Errors_Success:
            print("Success")
        default:
            print("ViewController Error \(ErrorType) \(details)")
            return
        }
    }
    
    func onSessionJoin() {
        print("E9mini UserSession Join!!!")
    }
    
    func onSessionLeave() {
        print("E9mini UserSession Leave!!!")
    }
}

//MARK: - LifeCycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        createJWT()
        pageInit()
    }
}

//TestJWT
extension ViewController{
    private func createJWT(){
        let alg = JWTAlgorithm.hs256(SDKSecretKey)
        let header = JWTHeader.init()
        let unixNow = Int64(Date().timeIntervalSince1970)
        var payload = JWTPayload()
        payload.expiration = Int(unixNow) + 86400 * 2 - 10 // Max : 2 Days
        payload.issueAt = Int(unixNow)// + 86400 * 2 - 10 // current TimeStamp
        payload.customFields = [
            "app_key": EncodableValue(value:SDKKey) //SDK_Key
            //            , "version" : EncodableValue(value: 1) // ?? 필요없는듯
            , "tpc" : EncodableValue(value: "e9mini") // Session name
            , "user_identity" : EncodableValue(value: "iPhoneSE2")
            //            , "user_identity" : EncodableValue(value: "iPhone12Pro") //스위치용
        
            
        ]
        
        myJWT = try? JWT.init(payload: payload, algorithm: alg, header: header)
        
        print("myJWT \(myJWT?.rawString)")
    }
}
