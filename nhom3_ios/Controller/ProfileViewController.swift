//
//  ProfileViewController.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/19/21.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    //Log out
    
    @IBAction func tapOnLogout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        }catch{
            self.view.makeToast("Logout fail!")
        }
    }
    
}
