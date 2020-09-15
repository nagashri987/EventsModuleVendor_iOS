//
//  vendorListingVC.swift
//  ParentcraftService
//
//  Created by admin on 26/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Toast_Swift

class vendorListingVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var listData: verticalListDAta?
    var resultData: [verticalResult]?
    var pushType: String?
    var vendorType : String?
    var name: String?
    
    @IBOutlet weak var verticleListTV: UITableView!
    @IBOutlet weak var mTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTitle.text = "Select Profile"
        self.verticleListTV.register(UINib(nibName: "vendorListCell", bundle: nil), forCellReuseIdentifier: "vendorListCell")
        
        
        getVendorVerticalList()
        
    }
    
    @IBAction func getInfo(_ sender: Any) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultData != nil
        {
            return (resultData!.count)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vendorListCell", for: indexPath) as! vendorListCell
        cell.selectionStyle = .none
        cell.name.text = self.resultData?[indexPath.row].name
        cell.address.text = self.resultData?[indexPath.row].address
        if let pic = self.resultData?[indexPath.row].profilePhoto {
            let url = String(format: "%@%@",URLConstatns.ImageBaseUrl,(pic))
            let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            cell.profilePic.sd_setImage(with: URL(string: urlString!),placeholderImage: UIImage(named: "profile"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        UserDefaults.standard.set(resultData?[indexPath.row].id, forKey: "masterVerticleId")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EventTypeVC") as! EventTypeVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    func getVendorVerticalList(){
        if Connectivity.isConnectedToInternet
        {
            self.getData()
            
        }else{
            self.view.makeToast("No Internet")
        }
    }
    
    func getData() {
        SVProgressHUD.show()
        let vendorId = UserDefaults.standard.string(forKey: "_id")
        ParentCraft_API_SERVICE.postApprovedVerticalListData(params:["id_vendor": vendorId as AnyObject,"id_vendortype": vendorType as AnyObject]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        self.listData = lResult
                        self.resultData = self.listData?.result
                        self.verticleListTV.reloadData()
                        
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
