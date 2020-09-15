//
//  LoginVC.swift
//  ParentCraftVendor
//
//  Created by admin on 30/06/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import ACFloatingTextfield
import Alamofire
import SVProgressHUD
import Toast_Swift

class LoginVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mNumberTF: ACFloatingTextField!
    @IBOutlet weak var mPasswordTF: ACFloatingTextField!
    
    @IBOutlet weak var mEyeBtn: UIButton!
    @IBOutlet weak var mLoginBtn: UIButton!
    @IBOutlet weak var mRememberBtn: UIButton!
    
    var RememberisSelected = false
    var PasswordisSelected = false
    var mLoginData: SignUpData?
    var mResultData:[sResult]?
    var resendOtp: OTPResend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mNumberTF.text = "nagashri.parentcraft@gmail.com"
        self.mPasswordTF.text = "12345678"
        InitialSetup()
        setUpdateUI(mNumberTF)
        setUpdateUI(mPasswordTF)
        
        if UserDefaults.standard.bool(forKey: "btn") == true
        {
            self.mNumberTF.text = UserDefaults.standard.string(forKey: "savedEmail")
            self.mPasswordTF.text = UserDefaults.standard.string(forKey: "savedPassword")
            self.mRememberBtn.setImage(UIImage(named: "checked"), for: .normal)
        }
        // *** Listen to keyboard show / hide ***
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
            if #available(iOS 11, *) {
                if keyboardHeight > 0 {
                    keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom
                }
            }
            //textViewBottomConstraint.constant = keyboardHeight + 8
            view.layoutIfNeeded()
        }
    }
    
    @objc func tapGestureHandler() {
        view.endEditing(true)
    }
    
    // MARK: - CommonFunction
    
    func InitialSetup(){
        mPasswordTF.isSecureTextEntry = true
        mEyeBtn.setImage(UIImage(named: "eyecross"), for: .normal)
        mRememberBtn.setImage(UIImage(named: "unchecked"), for: .normal)
        
    }
    
    func setUpdateUI(_ sender: ACFloatingTextField?){
        sender?.selectedLineColor = UIColor(red:0.00, green:0.69, blue:0.94, alpha:1.0)
        sender?.selectedPlaceHolderColor = UIColor(red:0.00, green:0.69, blue:0.94, alpha:1.0)
    }
    
    
    func shakeView(_ sender:ACFloatingTextField){
        
        let shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let from_point:CGPoint = CGPoint(x:sender.center.x - 5, y:sender.center.y)
        let from_value:NSValue = NSValue(cgPoint: from_point)
        let to_point:CGPoint = CGPoint(x:sender.center.x + 5, y:sender.center.y)
        let to_value:NSValue = NSValue(cgPoint: to_point)
        shake.fromValue = from_value
        shake.toValue = to_value
        sender.layer.add(shake, forKey: "position")
        
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: - UIButtonACtion
    @IBAction func mLoginAction(_ sender: Any) {
        //let bool = self.isValidEmail(testStr: mEmailTF.text!)
        if mRememberBtn.imageView?.image == UIImage(named: "checked") {
            UserDefaults.standard.set(true, forKey: "btn")
            UserDefaults.standard.set(self.mNumberTF.text!, forKey: "savedEmail")
            UserDefaults.standard.set(self.mPasswordTF.text!, forKey: "savedPassword")
        }else {
            UserDefaults.standard.set(false, forKey: "btn")
            UserDefaults.standard.set(nil, forKey: "savedEmail")
            UserDefaults.standard.set(nil, forKey: "savedPassword")
        }
        if mNumberTF.text == ""{
            self.view.makeToast("Please enter email id")
            shakeView(mNumberTF)
            return
        }else if mPasswordTF.text == ""{
            self.view.makeToast("Please enter password")
            shakeView(mPasswordTF)
            return
            
        }else{
            LoginApiCall()
        }
    }
    
    
    
    
    
    
    @IBAction func mPasswordSecueAction(_ sender: Any) {
        
        if PasswordisSelected == false{
            PasswordisSelected = true
            mPasswordTF.isSecureTextEntry = false
            mEyeBtn.setImage(UIImage(named: "eye"), for: .normal)
            
        }else{
            PasswordisSelected = false
            mPasswordTF.isSecureTextEntry = true
            mEyeBtn.setImage(UIImage(named: "eyecross"), for: .normal)
        }
        
    }
    @IBAction func mRememberMeAction(_ sender: Any) {
        
        if RememberisSelected == false{
            RememberisSelected = true
            mRememberBtn.setImage(UIImage(named: "checked"), for: .normal)
            UserDefaults.standard.set(true, forKey: "btn")
            UserDefaults.standard.set(self.mNumberTF.text!, forKey: "savedEmail")
            UserDefaults.standard.set(self.mPasswordTF.text!, forKey: "savedPassword")
            
            
        }else{
            RememberisSelected = false
            mRememberBtn.setImage(UIImage(named: "unchecked"), for: .normal)
            UserDefaults.standard.set(false, forKey: "btn")
            UserDefaults.standard.set(nil, forKey: "savedEmail")
            UserDefaults.standard.set(nil, forKey: "savedPassword")
            
        }
    }
    
    
    //API Call
    func LoginApiCall(){
        if Connectivity.isConnectedToInternet
        {
            self.getData()
            
        }else{
            self.view.makeToast("Please check your internet connection");
        }
    }
    
    func getData() {
        SVProgressHUD.show()
        ParentCraft_API_SERVICE.postLoginData(params: ["email": mNumberTF.text as AnyObject, "password": mPasswordTF.text as AnyObject]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        UserDefaults.standard.set("1", forKey: "isLoggedin")
                        UserDefaults.standard.set("1", forKey: "language")
                        self.mLoginData = lResult
                        
                        if let val = self.mLoginData?.result
                        {
                            self.mResultData = val
                            UserDefaults.standard.set(self.mLoginData?.key, forKey: "key")
                            self.mResultData = self.mLoginData?.result
                            UserDefaults.standard.set(self.mResultData?.first?.id, forKey: "_id")
                            UserDefaults.standard.set(self.mResultData?.first?.fullName, forKey: "name")
                            UserDefaults.standard.set(self.mResultData?.first?.dob, forKey: "dob")
                            UserDefaults.standard.set(self.mResultData?.first?.gender, forKey: "gender")
                            
                            UserDefaults.standard.set(self.mResultData?.first?.age, forKey: "age")
                            UserDefaults.standard.set(self.mResultData?.first?.email, forKey: "email")
                            UserDefaults.standard.set(self.mResultData?.first?.mobile, forKey: "mobile")
                            UserDefaults.standard.set(self.mResultData?.first?.state, forKey: "state")
                            UserDefaults.standard.set(self.mResultData?.first?.city, forKey: "city")
                            UserDefaults.standard.set(self.mResultData?.first?.pic, forKey: "pic")
                            UserDefaults.standard.set(self.mResultData?.first?.lat, forKey: "lat")
                            UserDefaults.standard.set(self.mResultData?.first?.lon, forKey: "lon")
                            UserDefaults.standard.set(self.mLoginData?.vendor_master_verticle_id, forKey: "proMasterId")
                           
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else
                        {
                            self.view.makeToast(self.mLoginData?.message)
                           
                        }
                        
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
