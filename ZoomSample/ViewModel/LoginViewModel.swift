//
//  LoginViewModel.swift
//  ZoomSample
//
//  Created by esmnc1 on 2022/01/21.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let bag = DisposeBag()
    let sessionName = BehaviorRelay<String>(value: "")
    let sessionPassword = BehaviorRelay<String?>(value: nil)
    let userName = BehaviorRelay<String?>(value: nil)
    let tapJoinBtn = PublishRelay<Void>()
    let tapCreateBtn = PublishRelay<Void>()
//    let goMain = PublishRelay<Void>()
    
    let currentViewController : UIViewController
    
    init( _ currentVC : UIViewController){
        self.currentViewController = currentVC
        bind()
    }
}

extension LoginViewModel{
    private func bind(){
        
        tapJoinBtn
            .withLatestFrom(Observable.combineLatest(sessionName,sessionPassword,userName))
            .bind{[weak self] (session, password, nickName) in
                self?.goMain()
            }
            .disposed(by: bag)
        
    }
    
    func isValid() -> Observable<Bool>{
        sessionName.map{ sName in
            return true
            return sName != ""
        }
    }
    
    func goMain(){
        let mainVC = MainViewController()
        mainVC.loginUser = UserModel(sessionName: sessionName.value, sessionPassword: sessionPassword.value, name: userName.value ?? nil, userIdentity: "\(sessionName.value)_\(userName.value ?? "temp")")
        
        self.currentViewController.navigationController?.pushViewController(mainVC, animated: true)
    }
}
