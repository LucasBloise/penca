//
//  ViewController.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if SessionManager.shared.isLoggedIn {
           
            let matchesVC = StoryboardScene.Matches.initialScene.instantiate()
            matchesVC.modalPresentationStyle = .overCurrentContext
            self.present(matchesVC, animated: false)
        } else {
            let signUpVC = StoryboardScene.Onboarding.sigInViewController.instantiate()
            signUpVC.modalPresentationStyle = .overCurrentContext
            self.present(signUpVC, animated: false)
        }
        
    }

}
