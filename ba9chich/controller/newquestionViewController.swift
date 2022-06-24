//
//  newquestionViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit

class newquestionViewController: UIViewController {

    var userviewmodelm = userVM()
    var questionviewmodel = expenseVM()

    
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var subject: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if(subject.text == ""){
            prompt(title: "warning", message: "item is empty")
        }else  if(price.text == ""){
            prompt(title: "warning", message: "price is empty")
        }else {
            questionviewmodel.createexpense(item: subject.text!, price: price.text! + " DT", userId: (userviewmodelm.userToken?._id)!)
         
            prompt(title: "Succes", message: "Expence added successfully")
        }
        
    }
    
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }

}
