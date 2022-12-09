//
//  PicsumImageDetailViewModel.swift
//  LoremPicsum
//
//  Created by Ansal Antony on 12/06/22.
//

import Foundation
import UIKit

public class PicsumImageDetailViewModel {
    
    var imageDeatils: ImageListModel? = nil
  
    
    init() {
        
    }
   
    func setupImageUrl(imageId:String, imgWedith:CGFloat, imgHeight:CGFloat, imageStyle:String, blurAmount:String) -> String {
        if(imageId != ""){
            let imageWedith = imgWedith + 120
            let imgWedithStr = String(format: "%.0f", Double(imageWedith))
            let imageheight =  imgHeight + 40
            let imgHeightStr = String(format: "%.0f", Double(imageheight))
            
            var urlValue = ServiceUrl.imageBaseUrl + imageId + "/" + imgWedithStr + "/" + imgHeightStr
            
            if(imageStyle == ConstantsLocaleKeys.grayscale){
                urlValue = urlValue + ServiceUrl.AppSubUrls.grayscale
            }
            if(imageStyle == ConstantsLocaleKeys.blur){
                urlValue = urlValue + ServiceUrl.AppSubUrls.blur + blurAmount
            }
            
            return urlValue
        }
        return ""
    }
}
