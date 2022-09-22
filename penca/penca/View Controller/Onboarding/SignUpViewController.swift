//
//  SignUpViewController.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var didTapSignUp: UIButton!
    @IBOutlet private weak var logInLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        logInLabel.isUserInteractionEnabled = true
        logInLabel.addGestureRecognizer(labelTap)
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        let logInVC = StoryboardScene.Main.logInViewController.instantiate()
        show(logInVC, sender: nil)
    }
    
    @IBAction private func didTapCreate(_ sender: UIButton) {
        APIClient.shared.postSignUp(userEmail: emailTextField.text ?? "", userPassword: passwordTextField.text ?? "") { apiResponse in
            switch apiResponse {
            case .success(let user):
                SessionManager.shared.setSessionToken(user.token)
            case .failure(let error):
                print(error)
                self.presentError(error)            }
        }
    }
    
}
