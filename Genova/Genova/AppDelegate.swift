//
//  AppDelegate.swift
//  Genova
//
//  Created by home on 19/08/23.
//

import UIKit
import IQKeyboardManager

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared().isEnabled = true

        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeController") as? HomeController {

            let navVc = UINavigationController(rootViewController: vc)
            navVc.isNavigationBarHidden = true
            self.window?.rootViewController = navVc
        }
        self.window?.makeKeyAndVisible()
        
        
        return true
    }
    
}

