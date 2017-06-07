//
//  FractalFriendCoordinator.swift
//  FractalFriend
//
//  Created by Freddy Hernandez on 12/6/16.
//  Copyright © 2016 Freddy Hernandez. All rights reserved.
//

import UIKit

class FractalFriendCoordinator {

    func start(in window:UIWindow) -> Void {
        let fractalController =  FractalController(nibName:"FractalController", bundle: nil);
        let nav = UINavigationController(rootViewController: fractalController)
        nav.setNavigationBarHidden(false, animated: false)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
}
