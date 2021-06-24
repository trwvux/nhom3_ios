//
//  AddActicleViewController.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/23/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddActicleViewController: UIViewController {
    var ref : DatabaseReference{
        return Database.database().reference()
    }
    var create:String?
    
    var name:String?
    let curUser = Auth.auth().currentUser!.uid
    @IBOutlet weak var txtContent: UITextView!
    
    @IBOutlet weak var txtTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        create = timestamp
        let postRef = ref.child("user").child(curUser)
        let refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            self.name = value["name"] as? String
        })
    }
    @IBAction func tapOnSaveActicle(_ sender: Any) {
        if txtTitle.text == nil || txtContent.text == nil{
            self.view.makeToast("Please enter all field")
        }
        else{
            let title = txtTitle.text
            let content = txtContent.text
            self.ref.child("acticle").childByAutoId().setValue(["username":name,"title":title,"content":content,"create":create])
            self.view.makeToast("Add acticle succesful")
            txtTitle.text = ""
            txtContent.text = ""
        }
    }
}
