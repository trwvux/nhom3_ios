//
//  File.swift
//  nhom3_ios
//
//  Created by Nguyễn Phi Trường Vũ on 6/21/21.
//

import Foundation
import UIKit

class Acticles {
        var username:String
        var title:String
        var content:String
        var create:String
        
        init(data: AnyObject){
            let dulieu = data as! Dictionary<String , AnyObject>
            username = dulieu["username"] as! String
            title = dulieu["title"] as! String
            content = dulieu["content"] as! String
            create = dulieu["create"] as! String
    }
}
