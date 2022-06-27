//
//  mailViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit
import Alamofire
class mailViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{

   //var
    var usertable = [Userr]()
    var userviewmodelm = userVM()
    var messagerieviewmodel = transactionVM()
    var movie : Transaction?
    private let refreshControl = UIRefreshControl()
   
    
 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var data = [Transaction]()
    var filteredData = [Transaction]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return filteredData.count //6 elements
       }
       
       
       
       
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
          
           let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
           let contentView = cell?.contentView
           
           let subject = contentView?.viewWithTag(1) as! UILabel
           let text = contentView?.viewWithTag(3) as! UILabel
        //   let imageView = contentView?.viewWithTag(2) as! UIImageView
           let from = contentView?.viewWithTag(4) as! UILabel
          // imageView.layer.masksToBounds = false
         //  imageView.layer.borderColor = UIColor.black.cgColor
          // imageView.layer.cornerRadius = imageView.frame.height/2
          // imageView.clipsToBounds = true
           subject.text = "From: "+filteredData[indexPath.row].fromAdress!
           from.text = "To: "+filteredData[indexPath.row].toAdress!
           text.text = filteredData[indexPath.row].amount
         
           
        //   userviewmodelm.getOwnermail(OwnerId: (filteredData[indexPath.row].fromAdress)! , successHandler: {anomalyList in
         //      self.usertable = anomalyList
         //      print("alamofire :")
              
         //      var path = String("http://localhost:3000/"+(self.usertable[0].imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
          //     path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
          //            let url = URL(string: path)!
         //             print(url)
          //     imageView.af.setImage(withURL: url)
          //         }, errorHandler: {
           //            print("errorororoor")
            //       })
           
           
           return cell!
           
       }
       
     
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
            movie = filteredData[indexPath.row]
      //     performSegue(withIdentifier: "open", sender: movie)
           
       }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
                    //film.remove(at: indexPath.row)
            self.present(Alert.makeActionAlert(titre: "Success", message:  "Do you want to Delete Transaction ? ", action: UIAlertAction(title: "Delete", style: .default, handler: { action in
        
                self.messagerieviewmodel.deletequestion(id: (self.filteredData[indexPath.row]._id)!)
              
                        self.tableView.reloadData()
                
               
            })),animated: true)
           
                }
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: Transaction) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.fromAdress!.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        var path = String("http://localhost:3000/"+(self.userviewmodelm.userToken?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

              path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
               let url = URL(string: path)!
               print(url)
     
        
        messagerieviewmodel.getOwnerToy(successHandler: {anomalyList in
                  self.data = anomalyList
            self.data.forEach{ msg in if(msg.fromAdress == self.userviewmodelm.userToken?.email || msg.toAdress == self.userviewmodelm.userToken?.email ){self.filteredData.append(msg)} }
            self.data = self.filteredData
            self.filteredData.reverse()
            self.data.reverse()
          self.tableView.reloadData()
              }, errorHandler: {
                  print("errorororoor")
              })
         
        
      
 
   
     
  
        
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
        self.data.removeAll()
        self.filteredData.removeAll()
        tableView.reloadData()
        messagerieviewmodel.getOwnerToy(successHandler: {anomalyList in
                  self.data = anomalyList
            self.data.forEach{ msg in if(msg.fromAdress == self.userviewmodelm.userToken?.email || msg.toAdress == self.userviewmodelm.userToken?.email ){self.filteredData.append(msg)} }
            self.data = self.filteredData
            self.filteredData.reverse()
            self.data.reverse()
          self.tableView.reloadData()
            self.refreshControl.endRefreshing()
              }, errorHandler: {
                  print("errorororoor")
              })
         
      
   
       
                
                
            
        
    }
  

   //action
    
  
    
    @IBAction func newMessage(_ sender: Any) {
        performSegue(withIdentifier: "newMessege", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newMessege"{
            let destination = segue.destination as! newmailViewController
            destination.userviewmodelm = userviewmodelm
            
        }
        
    }
}
