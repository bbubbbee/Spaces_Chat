//
//  ViewController.swift
//  SpacesChat
//
//  Created by Darren Borromeo on 14/12/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Variables
    
    private let logoImageView: UIImageView = {
        let imageView         = UIImageView()
        imageView.image       = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address ..."
        field.backgroundColor = .white
        
        // Adds left buffer for text.
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password ..."
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        
        // Adds left buffer for text.
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Log In"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Register",
            style: .done,
            target: self,
            action: #selector(didTapRegisterButton))
        
        // Add delegates.
        emailField.delegate    = self
        passwordField.delegate = self
        
        /// Add subviews.
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /// Add frames.
        scrollView.frame = view.bounds
        
        let size = scrollView.width/2
        logoImageView.frame = CGRect(
            x: (scrollView.width-size)/2,
            y: 40,
            width: size,
            height: size)
        
        emailField.frame = CGRect(
            x: 30,
            y: logoImageView.bottom-40,
            width: scrollView.width-60,
            height: 52)
        
        passwordField.frame = CGRect(
            x: 30,
            y: emailField.bottom+10,
            width: scrollView.width-60,
            height: 52)
        
        loginButton.frame = CGRect(
            x: 30,
            y: passwordField.bottom+10,
            width: scrollView.width-60,
            height: 52)
    }
    
    // MARK: - Actions
    
    @objc private func didTapRegisterButton() {
        let vc = RegisterViewController()
        vc.title = "Register User"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// Handles user log in.
    @objc private func didTapLoginButton() {
        // Get off keyboard.
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()

        // Email and password authenticator.
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty,
              !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
//        // Firebase login.
//        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
//            guard let strongSelf = self else { return }
//            guard let result = authResult, error == nil else {
//                print("Failed to log in user with email: \(email)")
//                return
//            }
//
//            let user = result.user
//            print("Logged in user: \(user)")
//
//            // The user has logged on, get off login view.
//            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
//        })
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(
            title: "Whoops!",
            message: "Please enter all information to log in.",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}

// MARK: - Extensions

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField { passwordField.becomeFirstResponder() }
        else if textField == passwordField { didTapLoginButton() }
        
        return true
    }
}
