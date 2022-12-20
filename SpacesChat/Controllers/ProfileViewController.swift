//
//  ProfileViewController.swift
//  SpacesChat
//
//  Created by Darren Borromeo on 15/12/2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    // MARK: - Variables
    
    // References tableview that we added through Storyboards.
    @IBOutlet var tableView: UITableView!
    
    let data = ["Log Out"]
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate   = self
        tableView.dataSource = self
    }
}

// MARK: - TableView

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    /// Handles generating each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text          = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor     = .red
        return cell
    }
    
    /// Handles cell selection.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Create action sheet to confirm that user want to log out.
        let actionSheet = UIAlertController(
            title: "",
            message: "Are you sure you want to log out?",
            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(
            title: "Log Out",
            style: .destructive,
            handler: { [weak self] _ in
                
                guard let strongSelf = self else {  return }
                
                // Log out the user from firebase.
                do {
                    try FirebaseAuth.Auth.auth().signOut()
                    
                    // Go back to login view.
                    let vc = LoginViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    strongSelf.present(nav, animated: true)
                }
                catch {
                    print("Failed to log user out")
                }
            }))
        
        // Cancel logging out.
        actionSheet.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil))
        
        present(actionSheet, animated: true)        
    }
}
