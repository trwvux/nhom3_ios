//
//  InforUser.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/23/21.
//

import Foundation
import UIKit

class InforUser {
    var name:String
    var address:String
    var birthday:String
    var profession:String
    var gender:String
    init(data: AnyObject) {
        let dulieu = data as! Dictionary<String , AnyObject>
        name = dulieu["name"] as! String
        address = dulieu["address"] as! String
        birthday = dulieu["birthday"] as! String
        gender = dulieu["gender"] as! String
        profession = dulieu["profession"] as! String
        
    }
}
