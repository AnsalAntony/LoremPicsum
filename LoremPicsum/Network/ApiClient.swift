//
//  ApiClient.swift
//  Oddsium
//
//  Created by Ansal Antony on 11/06/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class ApiClient: NSObject {
    
    // MARK: Shared Instance
    static let sharedInstance = ApiClient()
    
    // calling API
    public func makeNetworkCallGet(params : Parameters?,APIName : String,headers: HTTPHeaders?,success:@escaping (JSON) -> Void, failure:@escaping (String,String) -> Void)
    {
        let urlmain = APIName
        let url = urlmain.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = ServiceUrl.ServiceValue.apiTimeout
        
        manager.request(url!, method: HTTPMethod.get, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { ( responseData) -> Void in
            switch responseData.result {
            case .success(let json):
                let statusCode = responseData.response?.statusCode
                if(statusCode == 200){
                    let resJson = JSON(json)
                    success(resJson)
                }else{

                    let errorTitle = ConstantsLocaleKeys.error
                    failure(Constants.couldNotCompleteMessage,errorTitle)
                }
            case .failure(let error):
                print(error.localizedDescription)
                failure(Constants.defaultErrorMessage,ConstantsLocaleKeys.error)
            }
        }
    }
    
}

