//
//  LoginViewController.swift
//  ZoomSample
//
//  Created by esmnc1 on 2022/01/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import Then

class LoginViewController: UIViewController {
    
    let bag : DisposeBag = DisposeBag()
    lazy var viewModel = LoginViewModel(self)
    let containerView : UIView = UIView()
    
    let sessionJoinBtn : UIButton = {
        
        let button = UIButton()
        button.setTitle("참여하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 7.5
        return button
    }()
    
    let sessionCreateBtn : UIButton = {
        
        let button = UIButton()
        button.setTitle("생성하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 7.5
        return button
    }()
    
    let sessionNameField : UITextField = {
        
        let textField = UITextField()
        textField.minimumFontSize = 17
        textField.placeholder = "세션 이름을 입력해주세요."
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.text = "e9mini"
        return textField
    }()
    
    let sessionPasswordField : UITextField = {
        
        let textField = UITextField()
        textField.minimumFontSize = 17
        textField.placeholder = "세션 패스워드를 입력해주세요(선택)"
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.text = "aab"
        return textField
    }()
    
    let userNameField : UITextField = {
        
        let textField = UITextField()
        textField.minimumFontSize = 17
        textField.placeholder = "닉네임을 입력해주세요(선택)"
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        textField.text = "iPhone6"
        return textField
    }()
    
    let btnStackView : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    let textFieldStackView : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
}

extension LoginViewController{
    
    private func setupViews(){
        self.view.backgroundColor = .white
        self.view.addSubview(containerView)
        self.containerView.addSubview(btnStackView)
        self.containerView.addSubview(textFieldStackView)
        self.textFieldStackView.addArrangedSubview(sessionNameField)
        self.textFieldStackView.addArrangedSubview(sessionPasswordField)
        self.textFieldStackView.addArrangedSubview(userNameField)
        self.btnStackView.addArrangedSubview(sessionCreateBtn)
        self.btnStackView.addArrangedSubview(sessionJoinBtn)
        
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textFieldStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        btnStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textFieldStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

extension LoginViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationCurve(.easeInOut)
        
        self.view.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: self.view.frame.size.height)
        UIView.commitAnimations()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationCurve(.easeInOut)
        
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        UIView.commitAnimations()
    }
}

extension LoginViewController{
    
    
    
    private func pageInit(){
        self.navigationController?.navigationBar.topItem?.title = "세션 참여"
        sessionNameField.delegate = self
        sessionPasswordField.delegate = self
        userNameField.delegate = self
    }
    
    private func bind(){
        self.view.rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ _ in
                self.view.endEditing(true)
            }
            .disposed(by: bag)
        
        sessionJoinBtn.rx.tap
            .bind(to: viewModel.tapJoinBtn)
            .disposed(by: bag)
        
        sessionCreateBtn.rx.tap
            .bind(to:viewModel.tapCreateBtn)
            .disposed(by: bag)
        
        sessionNameField.rx.text
            .orEmpty
            .bind(to:viewModel.sessionName)
            .disposed(by: bag)
        
        userNameField.rx.text
            .orEmpty
            .bind(to: viewModel.userName)
            .disposed(by: bag)
        
        sessionPasswordField.rx.text
            .orEmpty
            .bind(to: viewModel.sessionPassword)
            .disposed(by: bag)
        
        viewModel.isValid()
            .subscribe(onNext: { valid in
                self.sessionJoinBtn.alpha = valid ? 1 : 0.3
                self.sessionJoinBtn.isEnabled = valid
                self.sessionCreateBtn.alpha = valid ? 1 : 0.3
                self.sessionCreateBtn.isEnabled = valid
                
            })
            .disposed(by: bag)
    }
}

//MARK: - LifeCycle
extension LoginViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        pageInit()
        bind()
    }
}
