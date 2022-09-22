//
//  LogInViewController.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(labelTap)
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        let signUpVC = StoryboardScene.Main.initialScene.instantiate()
        show(signUpVC, sender: nil)
    }
    
    @IBAction private func didTapLogIn(_ sender: UIButton) {
        APIClient.shared.postLogIn(userEmail: emailTextField.text ?? "", userPassword: passwordTextField.text ?? "") { apiResponse in
            switch apiResponse {
            case .success(let user):
                SessionManager.shared.setSessionToken(user.token)
            case .failure(let error):
                print(error)
                self.presentError(error)
                
            }
        }
    }
    
}
