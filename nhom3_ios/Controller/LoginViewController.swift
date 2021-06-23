//
//  ViewController.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/19/21.
//

import UIKit
import FirebaseAuth
import Toast_Swift
import Firebase
import FirebaseDatabase
var curUserID:String?
class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    var ref: DatabaseReference{
        return Database.database().reference()
    }
    var check:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLogin()
        // Do any additional setup after loading the view.
        let postRef = ref.child("user")

        let refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
            if let postDist = snapshot.value as? [String:AnyObject]{
                for i in postDist {
                    if i.key == curUserID {
                        self.check = true
                    }
                }
            }
        })
    }
    
    //MARK: Auto Login
    func autoLogin() {
        curUserID = Auth.auth().currentUser?.uid
        if curUserID != nil{
            let src = storyboard?.instantiateViewController(identifier: "main") as! UITabBarController
            present(src, animated: true, completion: nil)
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
                    if self?.check == false{
                        let src = self?.storyboard?.instantiateViewController(identifier: "infor") as! InformationUserViewController
                        self?.navigationController?.pushViewController(src, animated: true)
                    }
                    else{
                        let src = self?.storyboard?.instantiateViewController(identifier: "main") as! UITabBarController
                            self?.present(src, animated: true, completion: nil)
                        
                    }
                    
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

