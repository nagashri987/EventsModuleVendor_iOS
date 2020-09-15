//
//  PayEventVC.swift
//  ParentcraftService
//
//  Created by Parentcraft India on 22/05/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Toast_Swift

class PayEventVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var payNowBtn: UIButton!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var imageCV: UICollectionView!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var orderNo: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var seat: UILabel!
    
    @IBOutlet weak var coins: UILabel!
    
    
    @IBOutlet weak var coinBalance: UILabel!
    @IBOutlet weak var tax2: UILabel!
    @IBOutlet weak var tax1: UILabel!
    @IBOutlet weak var total2: UILabel!
    
    @IBOutlet weak var exitCoinCount: UILabel!
    @IBOutlet var mExitView: UIView!
    @IBOutlet weak var messagelabel: UILabel!
    
    var type: String?
    var pushtype : String?
    var mDaata: EventListData?
    var mResult : [eventListResult]?
    var picArr : [Pic]?
    var eventId : Int?
    var coinbalance = 0
    var coinCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == "invoice" {
            payNowBtn.isHidden = true
            heading.text = "View Invoice"
        }else {
            payNowBtn.isHidden = false
            heading.text = "Pay Event"
        }
        
        invoiceApiCall()
        self.imageCV.register(UINib(nibName: "BannerCell", bundle: nil), forCellWithReuseIdentifier: "BannerCell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        if pushtype == "add"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MyEventsVC") as! MyEventsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func getInfo(_ sender: Any) {
        
    }
    
    
    @IBAction func cancelExit(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyEventsVC") as! MyEventsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func payNow(_ sender: Any) {
        if  coinCount > coinbalance{
            self.view.makeToast("Add coins")
        }else {
            payEventApiCall()
        }
    }
    
    
    @IBAction func getCoins(_ sender: Any) {
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if picArr != nil {
            return picArr!.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
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
    
    
    //MARK:- preview API CALL
    func invoiceApiCall(){
        if Connectivity.isConnectedToInternet
        {
            self.getData()
            
        }else{
            self.view.makeToast("Please check your internet connection");
        }
    }
    
    func getData() {
        let vendorID = UserDefaults.standard.string(forKey: "_id")
        SVProgressHUD.show()
        ParentCraft_API_SERVICE.eventSummaryData(params: [ "_id": eventId as AnyObject, "user_id": vendorID as AnyObject]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        self.mDaata = lResult
                        self.mResult = self.mDaata?.events
                        self.picArr = self.mResult?.first?.pic
                        self.coinBalance.text = "\(self.mResult?.first?.coin_balance ?? "0")"
                        self.eventTitle.text = self.mResult?.first?.title
                        self.orderNo.text = self.mResult?.first?.order_no
                        self.date.text = self.mResult?.first?.date
                        self.time.text = self.mResult?.first?.time
                        self.durationLabel.text = self.mResult?.first?.duration
                        self.seat.text = self.mResult?.first?.seatCapacity
                        self.price.text = self.mResult?.first?.priceSeat
                        self.tax1.text = "\(self.mResult?.first?.durationmin ?? 0) x 2"
                        self.tax2.text = "= \(self.mResult?.first?.coin_count ?? 0)"
                        self.coinCount = self.mResult?.first?.coin_count ?? 0
                        self.coinbalance = Int(self.mResult?.first?.coin_balance ?? "")! 
                        
                        self.imageCV.reloadData()
                        
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
    
    //MARK:- payevent API CALL
    func payEventApiCall(){
        if Connectivity.isConnectedToInternet
        {
            self.payData()
            
        }else{
            self.view.makeToast("Please check your internet connection");
        }
    }
    
    func payData() {
        let vendorID = UserDefaults.standard.string(forKey: "_id")
        SVProgressHUD.show()
        ParentCraft_API_SERVICE.payCoinData(params: [ "id_event": eventId as AnyObject, "user_id": vendorID as AnyObject,"coin_count": self.mResult?.first?.coin_count as AnyObject]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        self.messagelabel.text = lResult.message
                        self.exitCoinCount.text = "\(lResult.coin_count ?? 0)"
                        self.mExitView.frame = self.view.frame
                        self.view.addSubview(self.mExitView)
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
    
    
}
