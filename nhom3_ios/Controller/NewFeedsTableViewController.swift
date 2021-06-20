//
//  NewFeedsTableViewController.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/20/21.
//

import UIKit
import Firebase
import FirebaseDatabase

class NewFeedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tbNewFeeds: UITableView!
    
    var arrActicle: Array<Acticle> = Array<Acticle>()
    
    var ref: DatabaseReference{
        return Database.database().reference()
    }
        
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tbNewFeeds.delegate = self
        tbNewFeeds.dataSource = self
        let postRef = ref.child("acticle")

        let refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
            if let postDist = snapshot.value as? [String:AnyObject]{
                self.arrActicle.removeAll()
                for i in postDist {
                    self.arrActicle.append(Acticle(data: i.value))
                    print(i.value)
                }
            }

        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrActicle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewFeedsTableViewCell", for: indexPath) as! NewFeedsTableViewCell
        cell.lblName.text = arrActicle[indexPath.row].username
        cell.lblCreate.text = arrActicle[indexPath.row].create
        cell.tvTitle.text = arrActicle[indexPath.row].title
        return cell
    }
    
}
struct Acticle {
    var username:String
    var title:String
    var content:String
    var create:String
    
    init(data: AnyObject){
        let dulieu = data as? Dictionary<String , AnyObject>
        username = dulieu?["username"] as! String
        title = dulieu?["title"] as! String
        content = dulieu?["content"] as! String
        create = dulieu?["create"] as! String
    }
}

