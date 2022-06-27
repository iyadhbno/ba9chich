//
//  homeViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit
import Alamofire
import CometChatPro
extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
class homeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource , UISearchBarDelegate{
    var userviewmodelm = userVM()
    var questionviewmodel = expenseVM()
    private let refreshControl = UIRefreshControl()
   
    var movie : Expense?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var data = [Expense]()
    var filteredData = [Expense]()
    var usertable : Userr?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        return filteredData.count//6 elements
       }
       
       
    @IBOutlet weak var profile: UIImageView!
    
       
       
    @IBAction func buttonmsg(_ sender: Any) {
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
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        
           let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
           let contentView = cell?.contentView
           
           let label = contentView?.viewWithTag(1) as! UILabel
           let text = contentView?.viewWithTag(3) as! UILabel
         //  let imageView = contentView?.viewWithTag(2) as! UIImageView
           
        //   imageView.layer.masksToBounds = false
         //  imageView.layer.borderColor = UIColor.black.cgColor
         //  imageView.layer.cornerRadius = imageView.frame.height/2
          // imageView.clipsToBounds = true
           label.text = filteredData[indexPath.row].item
           text.text = filteredData[indexPath.row].price
         //  userviewmodelm.getOwnerToy(OwnerId: (filteredData[indexPath.row].userId)! , successHandler: {anomalyList in
           //    self.usertable = anomalyList
           //     print("alamofire :")
           //    print(self.usertable!)
           //    var path = String("https://backnodeios.herokuapp.com/"+(self.usertable?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           //     path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
           // let url = URL(string: path)!
           //   print(url)
           //  imageView.af.setImage(withURL: url)
           //       }, errorHandler: {
           //          print("errorororoor")
           //      })
          
      
           return cell!
           
       }
       
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if segue.identifier == "newQuestion"{
               let destination = segue.destination as! newquestionViewController
               destination.userviewmodelm = userviewmodelm
           }
       }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
                    //film.remove(at: indexPath.row)
            self.present(Alert.makeActionAlert(titre: "Success", message:  "Do you want to Delete Expense ? ", action: UIAlertAction(title: "Delete", style: .default, handler: { action in
        
                self.questionviewmodel.deletequestion(id: (self.filteredData[indexPath.row]._id)!)
              
                        self.tableView.reloadData()
                
               
            })),animated: true)
           
                }
        
        
    }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            movie = filteredData[indexPath.row]
          // performSegue(withIdentifier: "mSegue", sender: nil)
           
       }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: Expense) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.item!.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
     sleep(1)
        print("///////////////////////")
        var path = String("http://localhost:3000/"+(self.userviewmodelm.userToken?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                       let url = URL(string: path)!
                       print(url)
                
                profile.layer.masksToBounds = false
        profile.layer.borderColor = UIColor.black.cgColor
        profile.layer.cornerRadius = profile.frame.height/2
        profile.clipsToBounds = true
        profile.af.setImage(withURL: url)
       
          
        questionviewmodel.getOwnerToy(successHandler: {anomalyList in
            
                    self.data = anomalyList
            self.data.forEach{ msg in if(msg.userId == self.userviewmodelm.userToken?._id ){self.filteredData.append(msg)} }
          
            self.filteredData.reverse()
            self.data = self.filteredData
            self.tableView.reloadData()
                }, errorHandler: {
                    print("errorororoor")
                })
           
  
        //
        
       
        //
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
     
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Weather Data ...")
    }
   
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        fetchWeatherData()
    }
    
    private func fetchWeatherData() {
        filteredData.removeAll()
        data.removeAll()
        tableView.reloadData()
        questionviewmodel.getOwnerToy(successHandler: {anomalyList in
            self.data = anomalyList
    self.data.forEach{ msg in if(msg.userId == self.userviewmodelm.userToken?._id ){self.filteredData.append(msg)} }
  
    self.filteredData.reverse()
            self.data = self.filteredData
    self.tableView.reloadData()
            self.refreshControl.endRefreshing()
                }, errorHandler: {
                    print("errorororoor")
                })
              
                
            
        
    }
  

   
    
    @IBAction func addquestion(_ sender: Any) {
        performSegue(withIdentifier: "newQuestion", sender: sender)
    }
    
    
    
}
