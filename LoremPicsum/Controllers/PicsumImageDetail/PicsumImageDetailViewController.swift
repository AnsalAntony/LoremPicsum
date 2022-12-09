//
//  PicsumImageDetailViewController.swift
//  LoremPicsum
//
//  Created by Ansal Antony on 11/06/22.
//

import UIKit
import SDWebImage

class PicsumImageDetailViewController: UIViewController {
    
    @IBOutlet weak var constraintImageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var segmentImgStyle: UISegmentedControl!
    
    @IBOutlet weak var imageViewShowPhoto: UIImageView!
    
    @IBOutlet weak var viewImgDisply: UIView!
    
    @IBOutlet weak var SliderBluer: UISlider!
    
    @IBOutlet weak var labelImageName: UILabel!
    
    @IBOutlet weak var viewImageId: UIView!
    
    @IBOutlet weak var labelImageId: UILabel!
    
    var imageDetailViewModel = PicsumImageDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVIew()
        self.dataBind()
    }
    
    func setupVIew(){
        self.constraintImageViewHeight.constant = self.view.frame.width - 40
        self.viewImgDisply.dropShadow()
        self.viewImageId.layer.cornerRadius = 6
        self.viewImageId.layer.masksToBounds = true
        self.SliderBluer.isHidden = true
    }
    func dataBind(){
        let imgId = self.imageDetailViewModel.imageDeatils?.identifier ?? ""
        self.labelImageId.text = ConstantsLocaleKeys.imgaHash + imgId
        self.labelImageName.text = imageDetailViewModel.imageDeatils?.author ?? ""
        
        let imageUrl = self.imageDetailViewModel.setupImageUrl(imageId: self.imageDetailViewModel.imageDeatils?.identifier ?? "", imgWedith: self.viewImgDisply.frame.size.width, imgHeight:  self.view.frame.width,imageStyle:ConstantsLocaleKeys.normal,blurAmount:"")
        
        self.setImageToImageView(imgUrl: imageUrl)
    }
    func setImageToImageView(imgUrl:String){
        self.imageViewShowPhoto.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.imageViewShowPhoto.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder.jpeg"))
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sliderScrolled(_ sender: Any) {
        let scrolledValue = String(format: "%.0f", Double(self.SliderBluer.value.rounded()))
        print(scrolledValue)
        let imageUrl = self.imageDetailViewModel.setupImageUrl(imageId: self.imageDetailViewModel.imageDeatils?.identifier ?? "", imgWedith: self.viewImgDisply.frame.size.width, imgHeight:  self.view.frame.width,imageStyle:ConstantsLocaleKeys.blur,blurAmount:scrolledValue)
        
        self.setImageToImageView(imgUrl: imageUrl)
        
    }
    
    @IBAction func segemntClicked(_ sender: Any) {
        print(self.segmentImgStyle.selectedSegmentIndex)
        if(self.segmentImgStyle.selectedSegmentIndex == 0){
            self.SliderBluer.isHidden = true
            let imageUrl = self.imageDetailViewModel.setupImageUrl(imageId: self.imageDetailViewModel.imageDeatils?.identifier ?? "", imgWedith: self.viewImgDisply.frame.size.width, imgHeight:  self.view.frame.width,imageStyle:ConstantsLocaleKeys.normal,blurAmount:"")
            
            self.setImageToImageView(imgUrl: imageUrl)
        }
        if(self.segmentImgStyle.selectedSegmentIndex == 1){
            self.SliderBluer.isHidden = false
            self.SliderBluer.setValue(5, animated: true)
            
            let imageUrl = self.imageDetailViewModel.setupImageUrl(imageId: self.imageDetailViewModel.imageDeatils?.identifier ?? "", imgWedith: self.viewImgDisply.frame.size.width, imgHeight:  self.view.frame.width,imageStyle:ConstantsLocaleKeys.blur,blurAmount:ConstantsLocaleKeys.bluerInitalVal)
            
            self.setImageToImageView(imgUrl: imageUrl)
        }
        if(self.segmentImgStyle.selectedSegmentIndex == 2){
            self.SliderBluer.isHidden = true
            let imageUrl = self.imageDetailViewModel.setupImageUrl(imageId: self.imageDetailViewModel.imageDeatils?.identifier ?? "", imgWedith: self.viewImgDisply.frame.size.width, imgHeight:  self.view.frame.width,imageStyle:ConstantsLocaleKeys.grayscale,blurAmount:"")
            
            self.setImageToImageView(imgUrl: imageUrl)
        }
        
    }
    
}
