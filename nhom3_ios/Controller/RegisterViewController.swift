//
//  RegisterViewController.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/19/21.
//

import UIKit
import Firebase
import Toast_Swift

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRePassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Register
    @IBAction func tapOnRegister(_ sender: Any) {
        view.endEditing(true)
        //Check empty string
        if tfEmail.text == nil && tfPassword.text == nil && tfRePassword == nil{
            self.view.makeToast("Please enter all fields")
        }
        //Check password
        else if tfPassword.text != tfRePassword.text{
            self.view.makeToast("Password incorrect, please try again!")
        }
        else{
            Auth.auth().createUser(withEmail: tfEmail.text!, password:tfRePassword.text!) { (AuthData, Error) in
                if Error != nil{
                    self.view.makeToast(Error!.localizedDescription)
                }
//                else{
//                    self.view.makeToast("Register successful")
//                }
                //send verification mail
                AuthData?.user.sendEmailVerification { (Error) in
                    if Error != nil{
                        self.view.makeToast(Error!.localizedDescription)
                    }
                    else{
                        self.view.makeToast("Sent verification mail")
                    }
                }
            }
        }
        
    }
}
