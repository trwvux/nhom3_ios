//
//  NewFeedsTableViewCell.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/20/21.
//

import UIKit

class NewFeedsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCreate: UILabel!
     
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
