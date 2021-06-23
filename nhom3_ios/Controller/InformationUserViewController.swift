//
//  InformationUserViewController.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/23/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class InformationUserViewController: UIViewController {
    var ref: DatabaseReference{
        return Database.database().reference()
    }

    @IBOutlet weak var tfName: UITextField!
    
    @IBOutlet weak var tfAddress: UITextField!
    
    @IBOutlet weak var tfProfession: UITextField!
    
    @IBOutlet weak var tfBirthday: UITextField!
    
    @IBOutlet weak var swMale: UISwitch!
    
    @IBOutlet weak var swFemale: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // Switch value change
    @IBAction func tapOnMale(_ sender: Any) {
        if swMale.isOn == true{
            swFemale.isOn = false
        }
    }
    // Switch value change
    @IBAction func tapOnFemale(_ sender: Any) {
        if swFemale.isOn == true{
            swMale.isOn = false
        }
    }
    
    @IBAction func tapOnSave(_ sender: Any) {
        let name = tfName.text!
        let address = tfAddress.text!
        let birthday = tfBirthday.text!
        let profession = tfProfession.text!
        var gender:String = "Nam"
        if swFemale.isSelected == true {
            gender = "Nữ"
        }
        let curUser = Auth.auth().currentUser!.uid
        if name == nil || address == nil || birthday == nil || profession == nil{
            self.view.makeToast("Please enter all field")
        }
        else{
            self.ref.child("user").child(curUser).setValue(["name":name,"address":address,"birthday":birthday,"profession":profession,"gender":gender])
            let vc = storyboard!.instantiateViewController(identifier: "newfeeds") as! UITabBarController
            present(vc, animated: true, completion: nil)
        }
        
    }
}
