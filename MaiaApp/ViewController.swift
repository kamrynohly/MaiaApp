//
//  ViewController.swift
//  MaiaApp
//
//  Created by Kamryn Ohly on 1/13/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            if let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
            {
                home.modalPresentationStyle = .fullScreen
                UIApplication.topViewController()?.present(home, animated: true, completion: nil)
            }
        }
        // Do any additional setup after loading the view.
    }


}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let tabController = controller as? UITabBarController {
            return topViewController(controller: tabController.selectedViewController)
        }
        if let navController = controller as? UINavigationController {
            return topViewController(controller: navController.visibleViewController)
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


