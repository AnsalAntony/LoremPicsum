//
//  ServiceUrl.swift
//  LoremPicsum
//
//  Created by Ansal Antony on 11/06/22.
//

import Foundation

struct ServiceUrl {
    
    static let baseUrl = "https://picsum.photos/v2/list?page="
    static let imageBaseUrl = "https://picsum.photos/id/"
    
    struct ServiceValue {
        
        static let apiTimeout = 30.0
        
        static let ContentType = "Content-Type"
        static let ContentTypeVal = "application/json"
    }
    
    struct AppSubUrls {
        
        static let limit = "&limit="
        static let grayscale = "/?grayscale"
        static let blur = "/?blur="
    }
    
}
