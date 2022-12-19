//
//  ConversationsViewController.swift
//  SpacesChat
//
//  Created by Darren Borromeo on 15/12/2022.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
    }
    
    /// Notifies the view controller that its view was added to a view hierarchy.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    // MARK: - Actions
    
    /// Checks if the user is currently logged in. If not, go to login view.
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}
