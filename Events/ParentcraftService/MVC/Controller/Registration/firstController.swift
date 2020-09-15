//
//  firstController.swift
//  ParentcraftService
//
//  Created by Parentcraft India on 13/04/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class firstController: UIViewController {
    
    
    @IBOutlet var updateView: UIView!
    @IBOutlet weak var messageLabe: UILabel!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.skipBtn.isHidden = true
        let isLoggedin =  UserDefaults.standard.string(forKey: "isLoggedin")
        if(isLoggedin == "1")
        {
            
            self.moveToHome()
        }else{
            self.moveToInitialView()
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func update(_ sender: Any) {
        // UIApplication.shared.openURL(URL(string: mResult?.first?.link ?? "")!)
    }
    
    @IBAction func skipActn(_ sender: Any) {
        
    }
    
    
    
    
    func moveToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToInitialView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
