//
//  HostEventVC.swift
//  ParentcraftService
//
//  Created by Parentcraft India on 07/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Toast_Swift

class HostEventVC: UIViewController , UITextViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
    
    
    @IBOutlet weak var eventTitle: UITextField!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    @IBOutlet weak var remove1: UIButton!
    @IBOutlet weak var remove2: UIButton!
    @IBOutlet weak var removeImage3: UIButton!
    @IBOutlet weak var removeImage4: UIButton!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var charCountLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seatCapacity: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceTF: UITextField!
    
    @IBOutlet var mExitView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var dateExitView: UIView!
    
    @IBOutlet weak var freeImage: UIImageView!
    @IBOutlet weak var paidImage: UIImageView!
    
    @IBOutlet weak var paidView: UIView!
    
    @IBOutlet weak var paidViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var confirmAccountNumber: UITextField!
    @IBOutlet weak var ifscCode: UITextField!
    @IBOutlet weak var branch: UITextField!
    
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    @IBOutlet var durationView: UIView!
    
    @IBOutlet weak var PriceViewHeight: NSLayoutConstraint!
    @IBOutlet weak var priceView: UIView!
    
    @IBOutlet weak var durationTv: UITableView!
    
    
    var imagePicker = UIImagePickerController()
    var dateFormaatter = DateFormatter()
    var pickerType : String?
    var id : String?
    var date = ""
    var time = ""
    var duration = ""
    var imageNum : String?
    var image1url = ""
    var image2Url = ""
    var image3Url = ""
    var image4Url = ""
    
    var pics = ""
    var seat = ""
    var dateFormatter = DateFormatter()
    var durationArrStr = ["30 min","1 hr","1 hr 30 min","2 hr","2 hr 30 min","3 hr","3 hr 30 min","4 hr"]
    var durationArr = ["00:30:00","01:00:00","01:30:00","02:00:00","02:30:00","03:00:00","03:30:00","04:00:00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remove1.isHidden = true
        remove2.isHidden = true
        removeImage3.isHidden = true
        removeImage4.isHidden = true
        paidView.isHidden = true
        paidViewHeight.constant = 0
        PriceViewHeight.constant = 0
        priceView.isHidden = true
        contentViewHeight.constant = 850
        self.durationTv.register(UINib(nibName: "selectMonthCell", bundle: nil), forCellReuseIdentifier: "selectMonthCell")
        durationTv.reloadData()
        
    }
    
    
    func updateCharacterCount() {
        
        let descriptionCount = self.descriptionText.text.count
        
        
        
        self.charCountLabel.text = "\((0) + descriptionCount)/500 characters left"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if(textView == descriptionText){
            return textView.text.count +  (text.count - range.length) <= 500
        }
        return false
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func getInfo(_ sender: Any) {
        
    }
    
    @IBAction func image1Actn(_ sender: UIButton) {
        self.imageNum = "one"
        picSelection(sender: sender)
    }
    
    @IBAction func image2Actn(_ sender: UIButton) {
        self.imageNum = "two"
        picSelection(sender: sender)
    }
    
    @IBAction func image3Actn(_ sender: UIButton) {
        self.imageNum = "three"
        picSelection(sender: sender)
    }
    
    @IBAction func image4Actn(_ sender: UIButton) {
        self.imageNum = "four"
        picSelection(sender: sender)
    }
    
    @IBAction func removeAction1(_ sender: Any) {
        self.imageNum = "one"
        mExitView.frame = view.frame
        view.addSubview(mExitView)
    }
    
    @IBAction func removeAction2(_ sender: Any) {
        self.imageNum = "two"
        mExitView.frame = view.frame
        view.addSubview(mExitView)
    }
    
    @IBAction func removeAction3(_ sender: Any) {
        self.imageNum = "three"
        mExitView.frame = view.frame
        view.addSubview(mExitView)
    }
    
    @IBAction func removeAction4(_ sender: Any) {
        self.imageNum = "four"
        mExitView.frame = view.frame
        view.addSubview(mExitView)
        
    }
    
    @IBAction func removeExitView(_ sender: Any) {
        self.mExitView.removeFromSuperview()
    }
    
    @IBAction func removeImage(_ sender: Any) {
        if  self.imageNum == "one" {
            self.image1.image = UIImage(named: "Add Images.2")
            self.remove1.isHidden = true
            self.image1url = ""
        }else if  self.imageNum == "two" {
            self.image2.image = UIImage(named: "Add Images.2")
            self.remove2.isHidden = true
            self.image2Url = ""
        }else if  self.imageNum == "three" {
            self.image3.image = UIImage(named: "Add Images.2")
            self.removeImage3.isHidden = true
            self.image3Url = ""
        }else if  self.imageNum == "four" {
            self.image4.image = UIImage(named: "Add Images.2")
            self.removeImage4.isHidden = true
            self.image4Url = ""
        }
        self.mExitView.removeFromSuperview()
    }
    
    
    
    func picSelection(sender: UIButton){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            
            alert.popoverPresentationController?.sourceView = sender as! UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
            
        default:
            
            break
            
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Open the camera
    
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    func openGallary(){
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func selectDate(_ sender: Any) {
        pickerType = "date"
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        datePicker.datePickerMode = .date
        dateExitView.frame = view.frame
        view.addSubview(dateExitView)
        datePicker.addTarget(self, action: #selector(handleDatePicker1(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker1(sender: UIDatePicker) {
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        date  = dateFormatter.string(from: datePicker.date)
    }
    
    
    
    @IBAction func selectTime(_ sender: Any) {
        
        pickerType = "time"
        datePicker.datePickerMode = .time
        datePicker.minimumDate =  Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        dateExitView.frame = view.frame
        view.addSubview(dateExitView)
        datePicker.addTarget(self, action: #selector(handleDatePicker2(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker2(sender: UIDatePicker) {
        
        dateFormatter.dateFormat = "h:mm a"
        time  = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func selectDuration(_ sender: Any) {
        
        self.durationView.frame = view.frame
        self.view.addSubview(durationView)
        //           pickerType = "duration"
        //                    datePicker.datePickerMode = .countDownTimer
        //             datePicker.minimumDate =  Calendar.current.date(byAdding: .day, value: 30, to: Date())!
        //                dateExitView.frame = view.frame
        //                          view.addSubview(dateExitView)
        //                          datePicker.addTarget(self, action: #selector(handleDatePicker3(sender:)), for: .valueChanged)
        //                      }
        //
        //                      @objc func handleDatePicker3(sender: UIDatePicker) {
        //
        //                        dateFormatter.dateFormat = "HH:mm"
        //                        duration  = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func cancelDuration(_ sender: Any) {
        self.durationView.removeFromSuperview()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectMonthCell", for: indexPath) as! selectMonthCell
        cell.contentView.backgroundColor = UIColor.white
        cell.monthLabel.textColor = UIColor.black
        cell.monthLabel.text = durationArrStr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        duration = durationArr[indexPath.row]
        durationLabel.text = durationArrStr[indexPath.row]
        durationView.removeFromSuperview()
    }
    @IBAction func cancelDate(_ sender: Any) {
        if pickerType ==  "date"{
            date = ""
        }else if pickerType == "time"{
            time = ""
        }
        self.dateExitView.removeFromSuperview()
    }
    
    @IBAction func dateOkActn(_ sender: Any) {
        if pickerType ==  "date"{
            if date != ""{
                dateLabel.text = date
            }else {
                dateFormatter.dateFormat = "dd-MM-yyyy"
                dateLabel.text = dateFormatter.string(from: datePicker.minimumDate! )
            }
        }else if pickerType == "time"{
            if time != ""{
                timeLabel.text = time
            }else {
                dateFormatter.dateFormat = "H:mm a"
                timeLabel.text = dateFormatter.string(from: datePicker.minimumDate!)
            }
        }
        //            else{
        //                if duration != ""{
        //                    durationLabel.text = duration
        //                }else {
        //                   dateFormatter.dateFormat = "HH:mm"
        //                    durationLabel.text = dateFormatter.string(from: datePicker.date)
        //                }
        //            }
        self.dateExitView.removeFromSuperview()
    }
    
    
    @IBAction func isPaid(_ sender: Any) {
        seat = "paid"
        paidImage.image = UIImage(named: "selected")
        freeImage.image = UIImage(named: "notselected")
        paidView.isHidden = false
        paidViewHeight.constant = 410
        priceView.isHidden = false
        PriceViewHeight.constant = 40
        contentViewHeight.constant = 1300
        
    }
    
    @IBAction func isFree(_ sender: Any) {
        seat = "free"
        freeImage.image = UIImage(named: "selected")
        paidImage.image = UIImage(named: "notselected")
        paidView.isHidden = true
        paidViewHeight.constant = 0
        priceView.isHidden = true
        PriceViewHeight.constant = 0
        contentViewHeight.constant = 890
        
    }
    
    @IBAction func proceedActn(_ sender: Any) {
        var imageArr : [String] = []
        if image1url != "" {
            imageArr.append(image1url)
        }
        if image2Url != "" {
            imageArr.append(image2Url)
        }
        if image3Url != "" {
            imageArr.append(image3Url)
        }
        if image4Url != "" {
            imageArr.append(image4Url)
            
        }
        
        self.pics =
            imageArr.joined(separator: ",")
        if eventTitle.text == "" {
            self.view.makeToast("Please enter event title")
            return
        }else  if pics == "" {
            self.view.makeToast("Please add image")
            return
        }
        else if descriptionText.text == "" {
            self.view.makeToast("Please enter description")
            return
        }
        else if dateLabel.text == "" {
            self.view.makeToast("Please enter date")
            return
        }
        else if timeLabel.text == "" {
            self.view.makeToast("Please enter time")
            return
        }
        else if durationLabel.text == "" {
            self.view.makeToast("Please enter duration")
            return
        }
        else if seatCapacity.text == "" {
            self.view.makeToast("Please enter seat capacity")
            return
        }
            
        else if priceTF.text == "" {
            self.view.makeToast("Please enter price")
            return
        }else if seat  == "" {
            self.view.makeToast("Please select seat type")
            return
        }
        else if seat == "free"{
            addEventApiCall()
        }else {
            if accountName.text == "" {
                self.view.makeToast("Please enter account name")
                return
            }
            else if accountNumber.text == "" {
                self.view.makeToast("Please enter account number")
                return
            }
            else if confirmAccountNumber.text == "" {
                self.view.makeToast("Please enter confirm account number")
                return
            }
            else if accountNumber.text != confirmAccountNumber.text {
                self.view.makeToast("Entered account number and confirm account number do not match")
                return
            }
            else if ifscCode.text == "" {
                self.view.makeToast("Please enter ifsc cofde")
                return
            }
            else if branch.text == "" {
                self.view.makeToast("Please enter branch")
                return
            }else {
                addEventBankDetailsApiCall()
            }
            
        }
        
        
    }
    //API CALL
    func addEventApiCall(){
        if Connectivity.isConnectedToInternet
        {
            self.addData()
            
        }else{
            self.view.makeToast("Please check your internet connection");
        }
    }
    
    
    func addData() {
        SVProgressHUD.show()
        let vendorId = UserDefaults.standard.string(forKey: "_id")
        //  let lat = UserDefaults.standard.string(forKey: "lat")
        //   let lon = UserDefaults.standard.string(forKey: "lon")
        //  let state = UserDefaults.standard.string(forKey: "state")
        // let city = UserDefaults.standard.string(forKey: "city")
        let masterId = UserDefaults.standard.string(forKey: "masterVerticleId")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date1 = dateFormatter.date(from: dateLabel.text!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: date1!)
        dateFormatter.dateFormat = "h:mm a"
        let time1 = dateFormatter.date(from: timeLabel.text!)
        dateFormatter.dateFormat = "HH:mm"
        let timeStr = dateFormatter.string(from: time1!)
        
        ParentCraft_API_SERVICE.addEvent(params: ["id_vendor":vendorId as AnyObject,"vendor_master_verticle_id":masterId as AnyObject,"cat_id":id as AnyObject,"title":eventTitle.text as AnyObject,"description":descriptionText.text as AnyObject,"date":dateStr as AnyObject,"time":"\(timeStr):00"  as AnyObject,"price_seat":priceTF.text as AnyObject,"pic":pics  as AnyObject ,"duration": duration as AnyObject,"seat_capacity": seatCapacity.text as AnyObject ]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "PayEventVC") as! PayEventVC
                        vc.eventId = lResult.id_event
                        vc.pushtype = "add"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
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
    
    
    //MARK:-  add event with bank detailsAPI CALL
    func addEventBankDetailsApiCall(){
        if Connectivity.isConnectedToInternet
        {
            self.addBankData()
            
        }else{
            self.view.makeToast("Please check your internet connection");
        }
    }
    
    
    func addBankData() {
        SVProgressHUD.show()
        let vendorId = UserDefaults.standard.string(forKey: "_id")
        //  let lat = UserDefaults.standard.string(forKey: "lat")
        //   let lon = UserDefaults.standard.string(forKey: "lon")
        //  let state = UserDefaults.standard.string(forKey: "state")
        // let city = UserDefaults.standard.string(forKey: "city")
        let masterId = UserDefaults.standard.string(forKey: "masterVerticleId")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date1 = dateFormatter.date(from: dateLabel.text!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: date1!)
        dateFormatter.dateFormat = "h:mm a"
        let time1 = dateFormatter.date(from: timeLabel.text!)
        dateFormatter.dateFormat = "HH:mm"
        let timeStr = dateFormatter.string(from: time1!)
        ParentCraft_API_SERVICE.addEvent(params: ["id_vendor":vendorId as AnyObject,"vendor_master_verticle_id":masterId as AnyObject,"cat_id":id as AnyObject,"title":eventTitle.text as AnyObject,"description":descriptionText.text as AnyObject,"date":dateStr as AnyObject,"time":"\(timeStr):00"  as AnyObject,"price_seat":priceTF.text as AnyObject,"pic":pics  as AnyObject ,"duration": "\(durationLabel.text ?? ""):00" as AnyObject,"seat_capacity": seatCapacity.text as AnyObject,"account_name":accountName.text as AnyObject,"account_number":accountNumber.text as AnyObject,"ifsc":ifscCode.text as AnyObject,"branch":branch.text as AnyObject ]) { (result, error) in
            if let lResult = result {
                
                if lResult.status == "success" {
                    SVProgressHUD.dismiss()
                    print(lResult)
                    DispatchQueue.main.async(execute: {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "PayEventVC") as! PayEventVC
                        vc.eventId = lResult.id_event
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
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

//MARK: - UIImagePickerControllerDelegate

extension HostEventVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage else {
                return
        }
        
        
        //Dismiss the UIImagePicker after selection
        
        picker.dismiss(animated: true, completion: nil)
        self.picUpload(pic: image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
        
    }
    func picUpload(pic : UIImage) {
        let image = pic
        let imgData = image.jpegData(compressionQuality: 0.75)
        let parameters = ["uploadto": "events"] //Optional for extra parameter
        SVProgressHUD.show()
        let headers: HTTPHeaders
        headers = ["Content-type": "multipart/form-data",
                   "Content-Disposition" : "form-data"]
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData!, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                
                multipartFormData.append((value ).data(using: String.Encoding.utf8)!, withName: key)
            }
            
        },to: "\(URLConstatns.ImageBaseUrl)api/upload/file", usingThreshold: UInt64.init(),
          method: .post,
          headers: headers).responseJSON(completionHandler: { data in
            
            let dict :NSDictionary = data.value! as! NSDictionary
            let status = dict.value(forKey: "status")as! String
            SVProgressHUD.dismiss()
            if status == "success" {
                
                
                let arr = dict.value(forKey: "filenames") as! Array<String>
                if self.imageNum == "one" {
                    self.image1.image = pic
                    self.image1url = arr.first ?? ""
                    self.remove1.isHidden = false
                }else   if self.imageNum == "two" {
                    self.image2.image = pic
                    self.image2Url = arr.first ?? ""
                    self.remove2.isHidden = false
                }
                else  if self.imageNum == "three" {
                    self.image3.image = pic
                    self.image3Url = arr.first ?? ""
                    self.removeImage3.isHidden = false
                    
                }
                else {
                    self.image4.image = pic
                    self.image4Url = arr.first ?? ""
                    self.removeImage4.isHidden = false
                }
                
            }
            
          })
    }
    
    
}

