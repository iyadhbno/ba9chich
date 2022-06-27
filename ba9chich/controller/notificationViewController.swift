//
//  notificationViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit
import Alamofire
import CometChatPro

class notificationViewController: UIViewController{

    var userviewmodelm = userVM()
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func msg(_ sender: Any) {
        let uid    = userviewmodelm.userToken?.phone
        let authKey = "3b27be4d0bb69a3f2aa54ef2d9ce2f0781edc534"

        CometChat.login(UID: uid!, apiKey: authKey, onSuccess: { (user) in
          print("Login successful: " + user.stringValue())
        }) { (error) in
          print("Login failed with error: " + error.errorDescription);
        }
        DispatchQueue.main.async {
        let cometChatUI = CometChatUI()
        cometChatUI.setup(withStyle: .pageSheet)
        self.present(cometChatUI, animated: true, completion: nil)
        }
    }
    
  
}
