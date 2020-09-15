//
//  DashboardVC.swift
//  ParentCraftVendor
//
//  Created by admin on 20/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Toast_Swift
import SDWebImage



class DashboardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var dashBoardVC: UICollectionView!
    
    @IBOutlet weak var networkView: UIView!
    //var titleArray = ["My Services", "Appointments", "Advertise", "Manage Ads", "Q & A", "Notifications", "Share", "Settings"]
    var mData : dashboardData?
    var mResult : [dashBoardResult]?
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkView.isHidden = true
        getdashBoradAPI()
        // getTokenAPICall()
        self.dashBoardVC.addSubview(self.refreshControl)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // getdashBoradAPI()
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor(red: 0.15, green: 0.69, blue: 0.95, alpha: 1.00)  
        
        return refreshControl
    }()
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        getdashBoradAPI()
        
    }
    
    
    @IBAction func retry(_ sender: Any) {
        getdashBoradAPI()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mResult != nil
        {
            return (mResult?.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        cell.dashboardLabel.text = mResult?[indexPath.row].name
        url = String(format: "%@%@",URLConstatns.ImageBaseUrl,(self.mResult?[indexPath.row].icon)!)
        cell.isUserInteractionEnabled = true
        
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        cell.dashboardImage.sd_setImage(with: URL(string: urlString!))
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 6
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MyEventsVC") as! MyEventsVC
            // vc.pushType = "Events"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.SCREEN_WIDTH/2 - 50 , height: Constant.SCREEN_HEIGHT/5 + 10 )
    }
    
    func getdashBoradAPI(){
        if Connectivity.isConnectedToInternet
        {
            networkView.isHidden = true
            self.getFormData()
            
        }else{
            self.view.makeToast("Please check your internet connection");
            networkView.isHidden = false
        }
    }
    
    func getFormData() {
        SVProgressHUD.show()
        let userId = UserDefaults.standard.string(forKey: "_id")
        ParentCraft_API_SERVICE.getDashBoardData(params:["id_vendor": userId as AnyObject]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        self.mData = lResult
                        self.mResult = self.mData?.result
                        // self.mResult = temp?.reversed()
                        self.dashBoardVC.reloadData()
                        
                        
                        
                    })
                } else {
                    SVProgressHUD.dismiss()
                    self.view.makeToast(lResult.message);
                    
                }
            }
            if let lError = error{
                SVProgressHUD.dismiss()
                self.view.makeToast(lError.localizedDescription);
                self.networkView.isHidden = false
                print(lError.localizedDescription)
            }
        }
        
    }
    
    
    
    
    
    
}
