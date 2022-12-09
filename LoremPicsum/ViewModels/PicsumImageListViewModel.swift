//
//  PicsumImageListViewModel.swift
//  LoremPicsum
//
//  Created by Ansal Antony on 12/06/22.
//

import Foundation
import UIKit

public class PicsumImageListViewModel {
    
    var imageListModel = [ImageListModel]()
    var page: Int = 1
    var isPageRefreshing:Bool = true
    
    
    typealias PicsumImageListCallBack = (_ status:Bool, _ errorTitle:String, _ errormesg:String) -> Void
    var imageListCallBack:PicsumImageListCallBack?
    
    //MARK:- take image list from Api
    func takeImageList(pageNumber:String, numerOfItems:String){
        NetworkManager.shared.getImageList(pageNumber: pageNumber,numerOfItems: numerOfItems, completionHandler: { (result) in
            DispatchQueue.main.async {
                if(result.isEmpty == true){
                    self.imageListCallBack?(false, "", Constants.noDataAvailable)
                }else{
                    self.imageListModel.append(contentsOf: result)
                    //self.imageListModel = result
                    self.imageListCallBack?(true,"","")
                }
            }
        }) { (Errormsg,ErrorTitle) in
            self.imageListCallBack?(false, ErrorTitle, Errormsg)
        }
    }
    //MARK:- ImagehListCompletionHandler
    func imageListCompletionHandler(callBack: @escaping PicsumImageListCallBack) {
        self.imageListCallBack = callBack
    }
    
    func setupImageUrl(imageId:String, ImgSize:CGFloat) -> String {
        if(imageId != ""){
            let cellHeightWedith = (ImgSize/2)-23
            let cellHeightWedithStr = String(format: "%.0f", Double(cellHeightWedith))
            
            let urlValue = ServiceUrl.imageBaseUrl + imageId + "/" + cellHeightWedithStr + "/" + cellHeightWedithStr
            return urlValue
        }
        return ""
    }
    
    func pagnation(){
        self.isPageRefreshing = true
        self.page = page + 1
        print(page)
        let PageStr = String(self.page)
        self.takeImageList(pageNumber: PageStr, numerOfItems: Constants.contentLimit)
    }
    
}
