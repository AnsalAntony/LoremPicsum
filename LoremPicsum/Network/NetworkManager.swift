//
//  NetworkManager.swift
//  Oddsium
//
//  Created by Ansal Antony on 24/05/22.
//

import UIKit
import SwiftyJSON
import Alamofire


class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    //MARK: get Image list
    func getImageList(pageNumber:String, numerOfItems:String, completionHandler:@escaping (_ responseVal:[ImageListModel]) -> Void,failure:@escaping (String,String) -> Void) {
        let apiName = ServiceUrl.baseUrl + pageNumber + ServiceUrl.AppSubUrls.limit + numerOfItems
        let HttpHeaders: HTTPHeaders
        HttpHeaders = [ServiceUrl.ServiceValue.ContentType : ServiceUrl.ServiceValue.ContentTypeVal]
        ApiClient.sharedInstance.makeNetworkCallGet(params: nil, APIName: apiName, headers: HttpHeaders, success: { (JSON) in
            //print(JSON)
            var imageListModel  = [ImageListModel]()
            if let results = JSON.array {
                for entry in results {
                    imageListModel.append(ImageListModel(content: entry))
                }
            }
            completionHandler(imageListModel)
        })
        { (Errormsg,ErrorTitle) in
            failure(Errormsg,ErrorTitle)
        }
    }
    
}


