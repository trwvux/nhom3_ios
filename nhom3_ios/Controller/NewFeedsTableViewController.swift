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
    
    var arrActicle: Array<Acticles> = Array<Acticles>()
    var ref: DatabaseReference{
        return Database.database().reference()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tbNewFeeds.delegate = self
        tbNewFeeds.dataSource = self
        tbNewFeeds.estimatedRowHeight = 300
        tbNewFeeds.rowHeight = UITableView.automaticDimension
        
        let postRef = ref.child("acticle")

        _ = postRef.observe(DataEventType.value, with: { (snapshot) in
            if let postDist = snapshot.value as? [String:AnyObject]{
                self.arrActicle.removeAll()
                for i in postDist {
                    let acticle = Acticles(data: i.value, key: i.key)
                    self.arrActicle.append(acticle)
                    self.tbNewFeeds.reloadData()
                }
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrActicle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as? NewFeedsTableViewCell{
            let acticle = arrActicle[indexPath.row]
            cell.lblName.text = acticle.username
            cell.lblCreate.text = acticle.create
            cell.lblTitle.text = acticle.title
            cell.lblContent.text = acticle.content
            return cell
        }
        else{
            fatalError("Error load new feeds")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var key: String?
        if let selectedCell = sender as? NewFeedsTableViewCell{
            for i in arrActicle{
                if i.username == selectedCell.lblName.text && i.create == selectedCell.lblCreate.text && i.title == selectedCell.lblTitle.text && i.content == selectedCell.lblContent.text{
                    key = i.key
                }
            }
            if let destinationController = segue.destination as? CommentViewController{
                destinationController.keyActicle = key!
            }
           
        }
    }
}


