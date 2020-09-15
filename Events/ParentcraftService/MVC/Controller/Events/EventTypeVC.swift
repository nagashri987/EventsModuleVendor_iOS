//
//  EventTypeVC.swift
//  ParentcraftService
//
//  Created by Parentcraft India on 21/05/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Toast_Swift

class EventTypeVC: UIViewController {
    
    
    @IBOutlet weak var hostBtn: UIButton!
    
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var linkBtn: UIButton!
    
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var linkImage: UIImageView!
    @IBOutlet weak var accouncementBtn: UIButton!
    
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var localImage: UIImageView!
    var type = ""
    var mData: EventTypeData?
    var mResult: [typeResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEventApiCall()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func getInfo(_ sender: Any) {
        
    }
    
    @IBAction func becomeHost(_ sender: Any) {
        type = "host"
        
        
    }
    
    @IBAction func shareLink(_ sender: Any) {
        type = "link"
        
    }
    
    @IBAction func localEvent(_ sender: Any) {
        type = "local"
        
    }
    
    @IBAction func next(_ sender: Any) {
        if type == "host"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HostEventVC") as! HostEventVC
            // UserDefaults.standard.set("", forKey: "address")
            vc.id = self.mResult?[0].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            self.view.makeToast("Select event type")
        }
    }
    
    //API CALL
    func getEventApiCall(){
        if Connectivity.isConnectedToInternet
        {
            self.getData()
            
        }else{
            self.view.makeToast("Please check your internet connection");
        }
    }
    
    func getData() {
        SVProgressHUD.show()
        ParentCraft_API_SERVICE.getEventType(params: nil) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        self.mData = lResult
                        self.mResult = self.mData?.result
                        let  url1 = String(format: "%@%@",URLConstatns.ImageBaseUrl,(self.mResult?[0].icon)!)
                        let urlString1 = url1.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                        self.hostImage.sd_setImage(with: URL(string: urlString1!))
                        self.hostLabel.text = self.mResult?[0].name
                        let  url2 = String(format: "%@%@",URLConstatns.ImageBaseUrl,(self.mResult?[1].icon)!)
                        let urlString2 = url2.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                        self.linkImage.sd_setImage(with: URL(string: urlString2!))
                        self.linkLabel.text = self.mResult?[1].name
                        let  url3 = String(format: "%@%@",URLConstatns.ImageBaseUrl,(self.mResult?[2].icon)!)
                        let urlString3 = url3.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                        self.localImage.sd_setImage(with: URL(string: urlString3!))
                        self.localLabel.text = self.mResult?[2].name
                        
                        
                        
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
