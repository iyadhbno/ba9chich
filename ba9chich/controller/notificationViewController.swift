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
        let uid    = userviewmodelm.userToken?.phone
        let authKey = "4426c753e2c6e4bb5882dbe65f85d72ace266fe2"

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
