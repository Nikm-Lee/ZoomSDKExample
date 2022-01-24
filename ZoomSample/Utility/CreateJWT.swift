//
//  CreateJWT.swift
//  ZoomSample
//
//  Created by esmnc1 on 2022/01/24.
//

import Foundation
import SwiftyJWT

private let SDKKey : String = "isct2jZPlNn7nn7nBNeLawX01b7IHOToipCI"
private let SDKSecretKey : String = "hiMtEEABUNq22H3JmQu6s2j0bWCUgMXzJe6f"

class CreateJWT {
    var loginUser : UserModel
    
    init(_ user : UserModel){
        loginUser = user
    }
    
    func createJWT() -> JWT?{
        
        let alg = JWTAlgorithm.hs256(SDKSecretKey)
        let header = JWTHeader.init()
        let unixNow = Int64(Date().timeIntervalSince1970)
        var payload = JWTPayload()
        payload.expiration = Int(unixNow) + 86400 * 2
        payload.issueAt = Int(unixNow)
        payload.customFields = [
            "app_key" : EncodableValue(value: SDKKey)
            ,"tpc" : EncodableValue(value: loginUser.sessionName)
            ,"user_identity" : EncodableValue(value: loginUser.userIdentity)
        ]
        
        let userJWT = try? JWT.init(payload: payload, algorithm: alg, header: header)

        return userJWT
    }
}
