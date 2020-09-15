//
//  MyEventsVC.swift
//  ParentcraftService
//
//  Created by Parentcraft India on 20/05/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Toast_Swift

class MyEventsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var clearAllBtn: UIButton!
    
    @IBOutlet weak var presentBtn: UIButton!
    @IBOutlet weak var pastBtn: UIButton!
    
    
    @IBOutlet weak var presentLabel: UILabel!
    @IBOutlet weak var pastLabel: UILabel!
    
    @IBOutlet weak var currentListView: UIView!
    
    @IBOutlet weak var currentNoData: UILabel!
    @IBOutlet weak var currentTv: UITableView!
    
    @IBOutlet weak var pastListView: UIView!
    
    @IBOutlet weak var pastNoData: UILabel!
    @IBOutlet weak var pastTv: UITableView!
    
    @IBOutlet var clearView: UIView!
    var currentData : EventListData?
    var currentResult :[eventListResult]?
    var pastData : EventListData?
    var pastResult :[eventListResult]?
    var popType : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentListView.isHidden = false
        pastListView.isHidden = true
        self.pastTv.register(UINib(nibName: "MyEventCell", bundle: nil), forCellReuseIdentifier: "MyEventCell")
        self.currentTv.register(UINib(nibName: "PastEventCell", bundle: nil), forCellReuseIdentifier: "PastEventCell")
        self.currentTv.register(UINib(nibName: "HostEventCell", bundle: nil), forCellReuseIdentifier: "HostEventCell")
        currentEventApiCall()
        pastEventApiCall()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // currentNoData.isHidden = true
        // pastNoData.isHidden = true
    }
    
    @IBAction func back(_ sender: Any) {
        
        if popType == "notification" {
            self.navigationController?.popViewController(animated: false)
        }else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func getInfo(_ sender: Any) {
        
    }
    
    @IBAction func clearAllActn(_ sender: Any) {
        self.clearView.frame = view.frame
        self.view.addSubview(clearView)
    }
    
    
    @IBAction func clearOkActn(_ sender: Any) {
        self.clearView.removeFromSuperview()
        
    }
    
    @IBAction func clearCancel(_ sender: Any) {
        self.clearView.removeFromSuperview()
    }
    
    @IBAction func addEvents(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VendorTypeVC") as! VendorTypeVC
        vc.pushType = "Events"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func currentBtn(_ sender: Any) {
        self.presentBtn.setTitleColor(UIColor(red:0.15, green:0.71, blue:0.95, alpha:1.0), for: .normal)
        
        self.pastBtn.setTitleColor(UIColor.black, for: .normal)
        
        self.presentLabel.backgroundColor = UIColor(red:0.15, green:0.71, blue:0.95, alpha:1.0)
        self.pastLabel.backgroundColor = UIColor.lightGray
        currentListView.isHidden = false
        pastListView.isHidden = true
    }
    
    @IBAction func pastBtn(_ sender: Any) {
        self.pastBtn.setTitleColor(UIColor(red:0.15, green:0.71, blue:0.95, alpha:1.0), for: .normal)
        
        self.presentBtn.setTitleColor(UIColor.black, for: .normal)
        
        self.pastLabel.backgroundColor = UIColor(red:0.15, green:0.71, blue:0.95, alpha:1.0)
        self.presentLabel.backgroundColor = UIColor.lightGray
        pastListView.isHidden = false
        currentListView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == currentTv{
            if currentResult != nil {
                return currentResult!.count
            }
        }
        else{
            if pastResult != nil {
                return pastResult!.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == currentTv {
            if currentResult?[indexPath.row].evevntCategory == "Become a Host" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HostEventCell", for: indexPath) as! HostEventCell
                cell.selectionStyle = .none
                if let pic = self.currentResult?[indexPath.row].bannerPic {
                    let url = String(format: "%@%@",URLConstatns.ImageBaseUrl,(pic))
                    let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                    cell.mImage.sd_setImage(with: URL(string: urlString!),placeholderImage: UIImage(named: "logo"))
                }
                cell.mName.text = currentResult?[indexPath.row].title
                cell.type.text = currentResult?[indexPath.row].evevntCategory
                cell.mDescription.text = currentResult?[indexPath.row].datumDescription
                cell.date.text = currentResult?[indexPath.row].date
                cell.status.text = "Status- \(currentResult?[indexPath.row].pay_status ?? "")"
                
                
                cell.startEvent.tag = indexPath.row
                cell.startEvent.addTarget(self, action:#selector(startEvent(_:)), for: UIControl.Event.touchUpInside)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PastEventCell", for: indexPath) as! PastEventCell
                cell.selectionStyle = .none
                if let pic = self.currentResult?[indexPath.row].bannerPic {
                    let url = String(format: "%@%@",URLConstatns.ImageBaseUrl,(pic))
                    let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                    cell.eventImage.sd_setImage(with: URL(string: urlString!),placeholderImage: UIImage(named: "logo"))
                }
                cell.eventTitle.text = currentResult?[indexPath.row].title
                cell.eventDate.text = currentResult?[indexPath.row].evevntCategory
                cell.eventType.text = currentResult?[indexPath.row].datumDescription
                cell.eventFee.text = "₹ \(currentResult?[indexPath.row].priceSeat ?? "0")"
                
                
                return cell
            }
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyEventCell", for: indexPath) as! MyEventCell
            cell.selectionStyle = .none
            if let pic = self.pastResult?[indexPath.row].bannerPic {
                let url = String(format: "%@%@",URLConstatns.ImageBaseUrl,(pic))
                let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                cell.eventImage.sd_setImage(with: URL(string: urlString!),placeholderImage: UIImage(named: "logo"))
            }
            cell.eventTitle.text = pastResult?[indexPath.row].title
            cell.eventDate.text = pastResult?[indexPath.row].evevntCategory
            cell.eventType.text = pastResult?[indexPath.row].datumDescription
            cell.eventFee.text = "₹ \(pastResult?[indexPath.row].priceSeat ?? "0")"
            
            return cell
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == currentTv {
            if currentResult?[indexPath.row].evevntCategory == "Become a Host"{
                return 237
            }else {
                return 160
            }
        }else {
            return 160
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == currentTv {
            
            
            
            if currentResult?[indexPath.row].evevntCategory == "Become a Host"{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "HostPreviewVC") as! HostPreviewVC
                vc.eventId = currentResult?[indexPath.row].id
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        }else {
            
        }
    }
    
    
    @objc func startEvent(_ sender: UIButton){
        //        let name = currentResult?[sender.tag].vendorName
        //
        //            let roomname = currentResult?[sender.tag].title
        //          authStore.signIn(
        //            userIdentity: name ?? "",
        //                     passcode:  "2002346734"
        //                 ) { [weak self] error in
        //                     guard let self = self, let window = self.view.window else { return }
        //
        //                     let authFlow = self.authFlowFactory.makeAuthFlow(window: window)
        //
        //
        //                     authFlow.roomName = roomname ?? ""
        //                     authFlow.didSignIn(error: error)
        //                 }
        
    }
    
    
    
    
    
    //MARK:- Current API CALL
    func currentEventApiCall(){
        if Connectivity.isConnectedToInternet
        {
            self.getcurrentData()
            
        }else{
            self.view.makeToast("Please check your internet connection");
        }
    }
    
    func getcurrentData() {
        let vendorID = UserDefaults.standard.string(forKey: "_id")
        SVProgressHUD.show()
        ParentCraft_API_SERVICE.postEventList(params: ["id_vendor": vendorID as AnyObject,"type" :"current" as AnyObject]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        self.currentData = lResult
                        self.currentResult = self.currentData?.data
                        if self.currentResult!.count > 0 {
                            self.currentNoData.isHidden = true
                        }else {
                            self.currentNoData.isHidden = false
                        }
                        self.currentTv.reloadData()
                        
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
    //MARK:- past API CALL
    func pastEventApiCall(){
        if Connectivity.isConnectedToInternet
        {
            self.getpastData()
            
        }else{
            self.view.makeToast("Please check your internet connection");
        }
    }
    
    func getpastData() {
        let vendorID = UserDefaults.standard.string(forKey: "_id")
        SVProgressHUD.show()
        ParentCraft_API_SERVICE.postEventList(params: ["id_vendor": vendorID as AnyObject,"type" :"past" as AnyObject]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        self.pastData = lResult
                        self.pastResult = self.pastData?.data
                        if self.pastResult!.count > 0 {
                            self.pastNoData.isHidden = true
                            self.clearAllBtn.isHidden = false
                        }else {
                            self.pastNoData.isHidden = false
                            self.clearAllBtn.isHidden = true
                        }
                        self.pastTv.reloadData()
                        
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
    
    //MARK:- clear All API CALL
    
    
    
    
}
