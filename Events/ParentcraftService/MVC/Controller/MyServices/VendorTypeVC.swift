//
//  VendorTypeVC.swift
//  ParentcraftService
//
//  Created by iMac on 06/01/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Toast_Swift

class VendorTypeVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var myServicesCV: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var listData: vendorListData?
    var resultData: [listResult]?
    var pushType: String?
    
    var type: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myServicesCV.register(UINib(nibName: "myServicesCell", bundle: nil), forCellWithReuseIdentifier: "myServicesCell")
        titleLabel.text = pushType
        getVendorList()
        
        
        
    }
    
    @IBAction func getInfo(_ sender: Any) {
        
    }
    //MARK:- COLLECTION VIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.resultData != nil {
            
            return (self.resultData?.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myServicesCell", for: indexPath) as! myServicesCell
        
        if resultData?[indexPath.row].count == 0{
            cell.backgroundImage.image = UIImage(named: "menu-bg-gray")
            cell.addImage.isHidden = true
            cell.listLabel.textColor = UIColor.black
            //cell.isUserInteractionEnabled = false
        }else{
            cell.backgroundImage.image = UIImage(named: "menu-bg-blue ")
            cell.addImage.isHidden = true
            cell.listLabel.textColor = UIColor.white
            //cell.isUserInteractionEnabled = true
        }
        
        cell.listLabel.text = self.resultData?[indexPath.row].name
        if let image = self.resultData?[indexPath.row].pic {
            let url = String(format: "%@%@",URLConstatns.ImageBaseUrl,(image))
            let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            cell.sevicesImage.sd_setImage(with: URL(string: urlString!))
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //if pushType == "QA"{
        if resultData?[indexPath.row].count == 0{
            self.view.makeToast("Create at least one vendor account")
            return
        }else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "vendorListingVC") as! vendorListingVC
            vc.name = resultData?[indexPath.row].name
            vc.vendorType = resultData?[indexPath.row].id
            vc.pushType = pushType
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //        }else{
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "VendorDetailsVC") as! VendorDetailsVC
        //        vc.vendorType = resultData?[indexPath.row].id
        //        self.navigationController?.pushViewController(vc, animated: true)
        //        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.SCREEN_WIDTH/2 - 20, height: Constant.SCREEN_HEIGHT/5 - 30)
    }
    
    
    //API Call
    func getVendorList(){
        if Connectivity.isConnectedToInternet
        {
            self.getData()
            
        }else{
            self.view.makeToast("No Internet")
        }
    }
    
    func getData() {
        let userId = UserDefaults.standard.string(forKey: "_id")
        SVProgressHUD.show()
        ParentCraft_API_SERVICE.approvedVendorListData(params:["id_vendor":userId as AnyObject ]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        self.listData = lResult
                        self.resultData = self.listData?.result
                        self.myServicesCV.reloadData()
                        
                        
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
    
    @IBAction func back(_ sender: Any) {
        if pushType == "Events" {
            self.navigationController?.popViewController(animated: false)
        }else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
            
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}

