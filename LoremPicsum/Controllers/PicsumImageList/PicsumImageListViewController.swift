//
//  PicsumImageListViewController.swift
//  LoremPicsum
//
//  Created by Ansal Antony on 11/06/22.
//

import UIKit
import SDWebImage

class PicsumImageListViewController: UIViewController {
    
    @IBOutlet weak var pagnitaionActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionViewImgList: UICollectionView!
    var imageListViewModel = PicsumImageListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNib()
        self.imageListServiceCall(pageNumber: self.imageListViewModel.page, numerOfItems: Constants.contentLimit)
        self.pagnitaionActivityIndicator.isHidden = true
    }
    
    // MARK: collectin cell
    func setupNib(){
        let nuibName = Constants.NibNames.imageListCollectionViewCell
        let nuibId = Constants.NibIdentifiers.imageListCollectionViewCellId
        self.collectionViewImgList.register(UINib(nibName: nuibName, bundle: nil), forCellWithReuseIdentifier: nuibId)
    }
    
    func imageListServiceCall(pageNumber:Int, numerOfItems: String) {
        if(pageNumber == 1){
            ProgressiveLoader.sharedInstance.showLoader(target: self, title:Constants.PleaseWait)
        }
        
        DispatchQueue.main.async {
            let pageNumStrung = String(pageNumber)
            
            self.imageListViewModel.takeImageList(pageNumber: pageNumStrung, numerOfItems: numerOfItems)
        }
        
        self.imageListViewModel.imageListCompletionHandler { [weak self] (status, errorTitle, errormesg) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if status {
                    ProgressiveLoader.sharedInstance.dismissLoader(target: self)
                    self.collectionViewImgList.reloadData()
                } else {
                    ProgressiveLoader.sharedInstance.dismissLoader(target: self)
                    self.alertPresent(title: errorTitle, message: errormesg)
                }
                self.imageListViewModel.isPageRefreshing = false
                self.pagnitaionActivityIndicator.stopAnimating()
                self.pagnitaionActivityIndicator.isHidden = true
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionViewImgList.contentOffset.y >= (self.collectionViewImgList.contentSize.height - self.collectionViewImgList.bounds.size.height)) {
            if !self.imageListViewModel.isPageRefreshing {
                
                self.pagnitaionActivityIndicator.isHidden = false
                self.pagnitaionActivityIndicator.startAnimating()
                self.imageListViewModel.pagnation()
            }
        }
    }
    
    
}

// MARK: collectin view Data source
extension PicsumImageListViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageListViewModel.imageListModel.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width/2)-23, height: (self.view.frame.size.width/2)-23);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PicsumImageListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.NibIdentifiers.imageListCollectionViewCellId, for: indexPath) as! PicsumImageListCollectionViewCell
        cell.dropShadow()
        let imageData = self.imageListViewModel.imageListModel[indexPath.item]
        let imageUrl = self.imageListViewModel.setupImageUrl(imageId: imageData.identifier ?? "", ImgSize: self.view.frame.size.width)
        cell.showListImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.jpeg"))
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let detailVC = UIStoryboard(name:Constants.stiryBoardMain, bundle:nil).instantiateViewController(withIdentifier:Constants.picsumImageDetailViewController) as! PicsumImageDetailViewController
        let imgDetails = self.imageListViewModel.imageListModel[indexPath.row]
        detailVC.imageDetailViewModel.imageDeatils = imgDetails
        self.navigationController?.show(detailVC, sender: self)
        
    }
}
