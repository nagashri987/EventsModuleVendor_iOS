//
//  AppDelegate.swift
//  ParentCraftVendor
//
//  Created by admin on 27/06/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
//import GoogleMaps
//import GooglePlaces
//import Firebase
//import UserNotifications
//import Crashlytics



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    var mNavCtrl: UINavigationController?

   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SingletonClass.sharedInstances.startUpdatingLocation()
       // GMSServices.provideAPIKey("AIzaSyDNTq6uqZdXZZjR6ui79hehmt2VyqxYB10")
        //GMSPlacesClient.provideAPIKey("AIzaSyDNTq6uqZdXZZjR6ui79hehmt2VyqxYB10")
        IQKeyboardManager.shared.enable = true
        
//        let isLoggedin =  UserDefaults.standard.string(forKey: "isLoggedin")
//        if(isLoggedin == "1")
//        {
//
//            self.moveToHome()
//        }else{
//            self.moveToInitialView()
//       }
        moveToInitialView()
        UIApplication.shared.windows.forEach { window in
            if #available(iOS 13.0, *) {
                window.overrideUserInterfaceStyle = .light
            } else {
                // Fallback on earlier versions
            }
              }
        
         
        //        recommendView = RecommnedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height ))
                UIApplication.shared.windows.forEach { window in
                    if #available(iOS 13.0, *) {
                        window.overrideUserInterfaceStyle = .light
                    } else {
                        // Fallback on earlier versions
                    }
                }
        
         //Fabric.sharedSDK().debug = true
        return true
    }
       //MARK: - Firebase Notifications
        
        func firebasepushNotification() {
            //Messaging.messaging().isAutoInitEnabled = true
            
//            let fcmToken = Messaging.messaging().fcmToken
//            UserDefaults.standard.set(fcmToken, forKey: "deviceToken")
//            print("FCM token: \(fcmToken ?? "")")
        }
        
      
        
        // [START receive_message]
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
            if let messageID = userInfo["aps"] {
                print("Message ID: \(messageID)")
            }
            // self.moveToNotificationVC()
            // Print full message.
            print(userInfo)
        }
        
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            // If you are receiving a notification message while your app is in the background,
            // this callback will not be fired till the user taps on the notification launching the application.
            // TODO: Handle data of notification
            
            // With swizzling disabled you must let Messaging know about the message, for Analytics
            // Messaging.messaging().appDidReceiveMessage(userInfo)
            
            // Print message ID.
            if let messageID = userInfo["aps"] {
                print("Message ID: \(messageID)")
            }
            
            // Print full message.
            print(userInfo)
            
            let state = UIApplication.shared.applicationState
            
            //        if state == .background {
            //            print("BACKGROUND STATE")
            //            self.moveToNotificationVC()
            //        }
            //        else if state == .active {
            //            print("ACTIVE STATE")
            //        }
            completionHandler(UIBackgroundFetchResult.newData)
        }
        
        // This method will be called when app received push notifications in foreground
        @available(iOS 10.0, *)
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
        {
            
            completionHandler([.alert, .badge, .sound])
        }
        
       @available(iOS 10.0, *)
            func userNotificationCenter(_ center: UNUserNotificationCenter,
                                        didReceive response: UNNotificationResponse,
                                        withCompletionHandler completionHandler: @escaping () -> Void) {
                let userInfo = response.notification.request.content.userInfo
                
                
                
                // Print message ID.
                if let messageID = userInfo["aps"] {
                    print("Message ID: \(messageID)")

                
                
                //        self.moveToNotificationVC()
                    }
                completionHandler()
            
        }
    

    func moveToInitialView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "firstController") as? firstController
    
        mNavCtrl = UINavigationController(rootViewController: myVC!)
        mNavCtrl?.isNavigationBarHidden = true
        mNavCtrl?.interactivePopGestureRecognizer?.isEnabled = false
        window?.rootViewController = mNavCtrl
        window?.makeKeyAndVisible()
    }

    
  

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

