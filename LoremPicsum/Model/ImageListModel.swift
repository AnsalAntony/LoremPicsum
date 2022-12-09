//
//  ImageListModel.swift
//  LoremPicsum
//
//  Created by Ansal Antony on 11/06/22.
//

import Foundation
import SwiftyJSON

class ImageListModel: NSObject {
    
    let identifier: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let downloadUrl: String?
   
    
    required init(content: JSON) {
        
        self.identifier = content["id"].stringValue
        self.author = content["author"].stringValue
        self.width = content["width"].intValue
        self.height = content["height"].intValue
        self.url = content["url"].stringValue
        self.downloadUrl = content["download_url"].stringValue
    
    }
}
