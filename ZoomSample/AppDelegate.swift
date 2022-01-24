//
//  AppDelegate.swift
//  ZoomSample
//
//  Created by esmnc1 on 2022/01/19.
//

import UIKit
import ZoomVideoSDK


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let initParams = ZoomVideoSDKInitParams()
//        initParams.domain = "https://zoom.us"
        initParams.domain = "zoom.us"
        initParams.enableLog = true
        
        let sdkInitReturnStatus = ZoomVideoSDK.shareInstance()?.initialize(initParams)

        switch sdkInitReturnStatus {
            case .Errors_Success:
                print("SDK initialized successfully")
            default:
                if let error = sdkInitReturnStatus {
                    print("SDK failed to initialize: \(error)")
            }
        }
        
        guard let main = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "main") as? ViewController else {return true}
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = LoginViewController()
        window?.rootViewController = RootViewController()
//        window?.rootViewController = main
        window?.makeKeyAndVisible()
        
        
        return true
    }

     
    func applicationWillTerminate(_ application: UIApplication) {
        ZoomVideoSDK.shareInstance()?.appWillTerminate()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        ZoomVideoSDK.shareInstance()?.appDidBecomeActive()
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        ZoomVideoSDK.shareInstance()?.appDidEnterBackgroud()
    }
    func applicationWillResignActive(_ application: UIApplication) {
        ZoomVideoSDK.shareInstance()?.appWillResignActive()
    }
}
