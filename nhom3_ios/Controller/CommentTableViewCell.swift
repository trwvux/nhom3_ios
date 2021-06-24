//
//  CommentTableViewCell.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/24/21.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
