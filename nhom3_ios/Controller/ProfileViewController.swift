//
//  ProfileViewController.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/19/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Toast_Swift

class ProfileViewController: UIViewController {
    
    var ref : DatabaseReference{
        return Database.database().reference()
    }
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblBirthday: UILabel!
    
    @IBOutlet weak var lblGender: UILabel!
    
    @IBOutlet weak var lblProfession: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let curUser = (Auth.auth().currentUser?.uid)!
        let postRef = ref.child("user").child(curUser)
        let email = Auth.auth().currentUser?.email
        let refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            self.lblName.text = value["name"] as? String
            self.lblProfession.text = value["profession"] as? String
            self.lblAddress.text = value["address"] as? String
            self.lblGender.text = value["gender"] as? String
            self.lblBirthday.text = value["birthday"] as? String
        })
        lblEmail.text = email
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
    //Send email chang password
    @IBAction func tapOnChangePassword(_ sender: Any) {
        let email = Auth.auth().currentUser!.email!
        Auth.auth().sendPasswordReset(withEmail: email) { (Error) in
            if Error != nil{
                self.view.makeToast(Error!.localizedDescription)
            }
            else{
                self.view.makeToast("Please check mail change your password")
            }
        }
    }
}
