//
//  HostPreviewVC.swift
//  ParentcraftService
//
//  Created by Parentcraft India on 08/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Toast_Swift

class HostPreviewVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    
    
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var payNowBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var imageCV: UICollectionView!
    
    @IBOutlet weak var seatCapacity: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var eventType: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var desViewHeight: NSLayoutConstraint!
    
    var mDaata: EventListData?
    var mResult : [eventListResult]?
    var picArr : [Pic]?
    var eventId: String?
    var textSize: CGSize? = nil
    var slideCount = 0
    var viewHeigt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.payNowBtn.isHidden = true
        self.imageCV.register(UINib(nibName: "BannerCell", bundle: nil), forCellWithReuseIdentifier: "BannerCell")
        previewApiCall()
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if picArr != nil {
            return picArr!.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.bannerImage.contentMode = .scaleToFill
        if let pic = self.picArr?[indexPath.row].pic {
            let url = String(format: "%@%@",URLConstatns.ImageBaseUrl,(pic))
            let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            cell.bannerImage.sd_setImage(with: URL(string: urlString!),placeholderImage: UIImage(named: "logo"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCV.frame.size.width, height: imageCV.frame.size.height)
    }
    
    @IBAction func payNowActn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PayEventVC") as! PayEventVC
        vc.eventId = Int(eventId ?? "")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- preview API CALL
    func previewApiCall(){
        if Connectivity.isConnectedToInternet
        {
            self.getData()
            
        }else{
            self.view.makeToast("Please check your internet connection");
        }
    }
    
    func getData() {
        // let vendorID = UserDefaults.standard.string(forKey: "_id")
        SVProgressHUD.show()
        ParentCraft_API_SERVICE.postEventDetails(params: [ "_id": eventId as AnyObject]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        self.mDaata = lResult
                        self.mResult = self.mDaata?.events
                        self.picArr = self.mResult?.first?.pic
                        if self.mResult?.first?.pay_status == "pending" /* && self.mResult?.first?.status == "approved" */{
                            self.payNowBtn.isHidden = false
                            self.viewHeigt = 750
                        }else {
                            self.payNowBtn.isHidden = true
                            self.viewHeigt = 690
                        }
                        self.dataDisplay()
                        
                    })
                } else {
                    SVProgressHUD.dismiss()
                    self.view.makeToast(lResult.message);
                    
                    
                    
                }
            }
            if let lError = error{
                print(lError.localizedDescription)
            }
        }
        
    }
    
    
    func dataDisplay(){
        pageControl.numberOfPages = picArr?.count ?? 0
        pageControl.currentPage = 0
        
        self.dateLabel.text = "\(self.mResult?.first?.date ?? "") at \(self.mResult?.first?.time ?? "")"
        self.eventTitle.text = self.mResult?.first?.title
        self.durationLabel.text = self.mResult?.first?.duration
        self.seatCapacity.text = self.mResult?.first?.seatCapacity
        self.priceLabel.text = self.mResult?.first?.priceSeat
        self.descriptionLabel.text = self.mResult?.first?.datumDescription
        let aSize = UIFont(name: "Ubuntu-Regular" as String, size: 15.0)
        let height = heightForView(text: self.descriptionLabel.text!, font: aSize!)
        //        if  let aSize = UIFont(name: "Ubuntu-Regular" as String, size: 15.0){
        //            textSize = self.descriptionLabel.text!.size(withAttributes: [NSAttributedString.Key.font : aSize])
        //        }
        
        // descriptionHeight.constant = textSize!.height
        desViewHeight.constant = height + 40
        viewHeight.constant = CGFloat(self.viewHeigt) + desViewHeight.constant
        self.imageCV.reloadData()
        //  let cellWidth: CGFloat? = textSize.width
        startTimer()
        
    }
    func startTimer() {
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.moveToCell), userInfo: nil, repeats: true)
        
        
    }
    @objc func moveToCell() {
        
        if self.slideCount == (self.picArr?.count ?? 0) - 1 {
            self.slideCount = 0
            let indexPath = IndexPath(row: self.slideCount, section: 0)
            self.pageControl.currentPage = self.slideCount
            //print(indexPath)
            self.imageCV.scrollToItem(at: indexPath, at: .left, animated: true)
            
        }else{
            self.slideCount = self.slideCount + 1
            let indexPath = IndexPath(row: self.slideCount, section: 0)
            self.pageControl.currentPage = self.slideCount
            //print(indexPath)
            self.imageCV.scrollToItem(at: indexPath, at: .left, animated: true)
        }
        
    }
    func heightForView(text:String, font:UIFont) -> CGFloat{
        
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.font = font
        descriptionLabel.text = text
        
        descriptionLabel.sizeToFit()
        return descriptionLabel.frame.height
    }
}



