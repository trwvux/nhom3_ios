//
//  Comment.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/24/21.
//

import Foundation
import UIKit

class Comments {
    var name:String?
    var comment:String?
    init(data: AnyObject){
        let temp = data as! Dictionary<String,AnyObject>
        name = temp["name"] as? String
        comment = temp["comment"] as? String
    }
    
}
