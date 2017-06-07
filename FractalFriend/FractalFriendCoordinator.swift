//
//  FractalFriendCoordinator.swift
//  FractalFriend
//
//  Created by Freddy Hernandez on 12/6/16.
//  Copyright © 2016 Freddy Hernandez. All rights reserved.
//

import UIKit
import Firebase

class FractalFriendCoordinator {

    func start(in window:UIWindow) -> Void {
        let fractalController =  FractalController(nibName:String.init(describing: FractalController.classForCoder()), bundle: nil)
        let loginController = LoginViewController(nibName: String.init(describing: LoginViewController.classForCoder()), bundle: nil)

        var root = UIViewController()
        if Auth.auth().currentUser != nil {
            root = fractalController
        } else {
            root = loginController
        }
        
        let nav = UINavigationController(rootViewController: root)
        nav.setNavigationBarHidden(false, animated: false)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
}
