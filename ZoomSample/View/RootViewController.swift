//
//  NavigationViewController.swift
//  ZoomSample
//
//  Created by esmnc1 on 2022/01/21.
//

import UIKit

class RootViewController: UINavigationController {

  

}
extension RootViewController{
    private func pageInit(){
        
    }
}
extension RootViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageInit()
        self.pushViewController(LoginViewController(), animated: true)
    }
}
