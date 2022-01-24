//
//  MainViewController.swift
//  ZoomSample
//
//  Created by esmnc1 on 2022/01/21.
//

import UIKit
import SnapKit
import ZoomVideoSDK
import RxSwift
import RxCocoa
import RxGesture
class MainViewController: UIViewController {

//    lazy var handler = ZoomHandler(loginUser ?? UserModel())
    var tempNumber = 0
    let bag = DisposeBag()
    lazy var handler = ZoomHandler(loginUser)
    
    
    let containerView = UIView()
    let mainUserView : UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemPink
        
        return view
        
    }()
    
    let collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGray
        return cv
    }()
    
    lazy var viewHieght = self.view.frame.height / 7
    var loginUser : UserModel?
    var joinUserArray : [ZoomVideoSDKUser]?
}

extension MainViewController{
    
    private func setupUI(){
        
        self.view.addSubview(containerView)
        self.containerView.addSubview(collectionView)
        self.containerView.addSubview(mainUserView)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(self.viewHieght + 50)
        }
        
        mainUserView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
    }
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return joinUserArray?.count ?? 1
//        return userArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else{ return UICollectionViewCell() }
        
        if indexPath.row < joinUserArray?.count ?? 0{
            if let usersVideoCanvas = joinUserArray?[indexPath.row].getVideoCanvas(){
                usersVideoCanvas.subscribe(with: cell.contentView, andAspectMode: .full_Filled)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: viewHieght, height: viewHieght)
        return size
    }
}
extension MainViewController{
    func bind(){
        handler.sessionJoinUser
            .distinctUntilChanged()
            .filter{$0 != nil}
            .subscribe(onNext:{ user in
                self.joinUserArray = user
                self.collectionView.reloadData()
                
            })
            .disposed(by: bag)
        
    }
    
}

extension MainViewController{
    private func pageInit(){
        self.view.backgroundColor = .white
        self.navigationItem.title = "메인"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
}


//MARK: - LifeCycle
extension MainViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        pageInit()
        setupUI()
        bind()
        handler.joinSession()
    }
}

class MainCollectionViewCell : UICollectionViewCell{
    static let identifier = "mainCell"
    
    var cellView : UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    func cellSetting(){
        self.addSubview(cellView)
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
