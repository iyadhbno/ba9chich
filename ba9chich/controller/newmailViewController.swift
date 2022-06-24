//
//  newmailViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit

class newmailViewController: UIViewController {

    var userviewmodelm = userVM()
    var messagerieviewmodel = transactionVM()
    var bool = false
    var mail : Transaction?
    @IBOutlet weak var submit: UIButton!
   
    
    @IBOutlet weak var Amount: UITextField!
    @IBOutlet weak var to: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(bool == true){
            to.text = mail?.fromAdress
        }
       
    }
    

    @IBAction func submit(_ sender: Any) {
        if(Amount.text == ""){
            prompt(title: "warning", message: "Amount is empty")
        }else  if(to.text == ""){
            prompt(title: "warning", message: "To is empty")
        }else {
            messagerieviewmodel.createtransaction(fromAdress: (userviewmodelm.userToken?.email)!, toAdress: to.text!, amount: Amount.text!)
            
            prompt(title: "Succes", message: "Transaction added successfully")
        }
       
    }
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }

}
