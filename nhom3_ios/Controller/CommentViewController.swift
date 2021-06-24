//
//  DetailActicleViewController.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/22/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var ref: DatabaseReference{
        return Database.database().reference()
    }
    var arrComment: [Comments] = []
    var keyActicle: String = ""
    var username:String = ""
    
    @IBOutlet weak var tbComment: UITableView!
    @IBOutlet weak var tfComment: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tfComment.text = keyActicle
        tbComment.delegate = self
        tbComment.dataSource = self
        let curUser = Auth.auth().currentUser?.uid
        ref.child("user").child(curUser!).observe(DataEventType.value) { (snapshot) in
                    let value = snapshot.value as! NSDictionary
            self.username = value["name"] as? String ?? ""
        }
        let postRef = ref.child("comment/\(keyActicle)")

        _ = postRef.observe(DataEventType.value, with: { (snapshot) in
            if let postDist = snapshot.value as? [String:AnyObject]{
                self.arrComment.removeAll()
                for i in postDist {
                    self.arrComment.append(Comments(data: i.value))
                    self.tbComment.reloadData()
                }
            }
        })
        
    }
    //buton back
    @IBAction func tapOnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //post comment
    
    @IBAction func tapOnPost(_ sender: Any) {
        if tfComment.text == nil{
            self.view.makeToast("Please enter your comment")
        }
        else{
            let comment = tfComment.text
            ref.child("comment/\(keyActicle)").childByAutoId().setValue(["name":username,"comment":comment])
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell",for: indexPath) as? CommentTableViewCell {
            cell.lblName.text = arrComment[indexPath.row].name
            cell.lblContent.text = arrComment[indexPath.row].comment
            return cell
        }
        else{
            fatalError("Error")
        }
    }
}
