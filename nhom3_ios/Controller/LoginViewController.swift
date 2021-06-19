//
//  ViewController.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/19/21.
//

import UIKit
import FirebaseAuth
import Toast_Swift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapOnLogin(_ sender: Any) {
        view.endEditing(false)
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) { (AuthData, Error) in
            if Error != nil{
                self.view.makeToast(Error!.localizedDescription)
            }
            else{
                self.view.makeToast("Login successful")
            }
        }
    }
    //forgot password
    @IBAction func tapOnForgotPassword(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: tfEmail.text!) { (Error) in
            if Error != nil {
                self.view.makeToast(Error!.localizedDescription)
            }
            else{
                self.view.makeToast("Please check your email to change password")
            }
        }
    }
}

