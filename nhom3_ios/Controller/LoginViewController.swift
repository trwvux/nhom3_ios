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
    
    //MARK: Auto Login
    func autoLogin() {
        let curUserID = Auth.auth().currentUser!.uid
        if curUserID != nil{
            
        }
    }

    @IBAction func tapOnLogin(_ sender: Any) {
        view.endEditing(true)
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) { [weak self] (AuthData, Error) in
            if Error != nil{
                self!.view.makeToast(Error!.localizedDescription)
            }
            else{
                //Verified account
                if AuthData!.user.isEmailVerified {
                    
                }
                else{
                    self!.view.makeToast("Your account have not verified yet")
                }
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

