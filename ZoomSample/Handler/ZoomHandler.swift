//
//  ZoomHandler.swift
//  ZoomSample
//
//  Created by esmnc1 on 2022/01/21.
//

import Foundation
import ZoomVideoSDK
import RxSwift
import RxRelay

class ZoomHandler : NSObject{
    
    let loginUser : UserModel
    
    var sessionJoinUser = BehaviorRelay<[ZoomVideoSDKUser]?>(value: nil)
    
    var joinUser : [ZoomVideoSDKUser] = []
    init(_ user : UserModel?){
        self.loginUser = user ?? UserModel(sessionName: "failSession", userIdentity: "")
        super.init()
        ZoomVideoSDK.shareInstance()?.delegate = self
    }
    
}
extension ZoomHandler : ZoomVideoSDKDelegate{
    //        ZoomVideoSDKVideoHelper().switchCamera()
    private func drawView(_ user : ZoomVideoSDKUser){
        
        if let usersVideoCanvas = user.getVideoCanvas(){
            let videoAspect = ZoomVideoSDKVideoAspect.panAndScan
            usersVideoCanvas.subscribe(with: UICollectionView(), andAspectMode: .full_Filled)
        }
    }
    
    private func stopView(_ user : ZoomVideoSDKUser){
        if let usersVideoCanvas = user.getVideoCanvas(){
            usersVideoCanvas.unSubscribe(with: UICollectionView())
        }
    }
}

extension ZoomHandler{
    func leaveSession(){
        ZoomVideoSDK.shareInstance()?.leaveSession(true);
    }
    func joinSession(){
        let sessionContext = ZoomVideoSDKSessionContext()
        sessionContext.token = CreateJWT(loginUser).createJWT()?.rawString
        sessionContext.sessionName = loginUser.sessionName
        sessionContext.sessionPassword = loginUser.sessionPassword
        sessionContext.userName = loginUser.name
        
        print("joinSessionUser : \(loginUser)")
        if let session = ZoomVideoSDK.shareInstance()?.joinSession(sessionContext){
            print("JoinSession is Success")
        }else{
            print("JoinSession is Failure")
        }
    }
}

extension ZoomHandler{
    func onSessionJoin() {
        print("User is Session Join")
    }
    
    func onSessionLeave() {
        print("User is Session Leave")
    }
    
    func onUserJoin(_ helper: ZoomVideoSDKUserHelper!, users userArray: [ZoomVideoSDKUser]!) {
        userArray.forEach{print("\($0.getName()) User is Join" )}
        if let userArray = userArray {
            for user in userArray {
                // 넣고 빼고를 키를 가지고 해야함

//                print("user => \(user)")
//                if (joinUser != nil){
//                    joinUser.append(user)
//                }else{
//                    joinUser = [user]
//                }
                print("nowUser : ", ZoomVideoSDK.shareInstance()?.getSession());
                print("nowUserID", user.getID())
                joinUser.append(user)
                
                print("join user => \(joinUser)")
                print("joinUserCnt \(joinUser.count)")
                sessionJoinUser.accept(joinUser)
                print("Join Count : ",sessionJoinUser.value?.count)
            }
        }
        
    }
    
    func onUserLeave(_ helper: ZoomVideoSDKUserHelper!, users userArray: [ZoomVideoSDKUser]!) {
        userArray.forEach{print("\($0.getName()) User is Leave")}
        
        if let userArray = userArray {
            for user in userArray {
                // 넣고 빼고를 키를 가지고 해야함
                print("remove LastUser : \(joinUser)")
                
                joinUser.removeLast(1)
                sessionJoinUser.accept(joinUser)
            }
        }
    }
    
    func onError(_ ErrorType: ZoomVideoSDKERROR, detail details: Int) {
        switch ErrorType {
        case .Errors_Success:
            print("Success")
        default:
            print("ViewController Error \(ErrorType) \(details)")
            return
        }
    }
}
