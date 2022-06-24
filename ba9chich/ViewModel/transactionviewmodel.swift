//
//  transactionviewmodel.swift
//  ba9chich
//
//  Created by User on 23.06.2022.
//

import Foundation
import Alamofire

class transactionVM {
    var AllTransaction = [Transaction]()
    
    func getOwnerToy(successHandler: @escaping (_ anomalyList: [Transaction] ) -> (),errorHandler: @escaping () -> ())
        {
            let url = "http://localhost:3000/transactions/allTransactions"
            print("getOwnerToy : "+url)
            
            AF.request(url, method: .get).validate().responseDecodable(of:  [Transaction].self, decoder: JSONDecoder()) { apiResponse in
                guard apiResponse.response != nil else{
                    errorHandler()
                    return
                }
                
                switch apiResponse.response?.statusCode {
                    
                    case 200:
                    successHandler(try! apiResponse.result.get())

                    
                    case 500:
                    errorHandler()
               
                default:
                  errorHandler()
                    
                }
                
            }
            
        }
    func getalltransaction()  {
       
        
        let jsonUrlString = "http://localhost:3000/getreponsesid/"
            guard let url = URL(string: jsonUrlString) else
            { return }

            URLSession.shared.dataTask(with: url) { (data, response, err) in

                guard let data =  data else{ return }

                do {
                    self.AllTransaction.removeAll()

                    let reponses = try JSONDecoder().decode([Transaction].self, from: data)
                 
                    reponses.forEach { user in self.AllTransaction.append(user) }
                    
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }

            }.resume()
    }
    
    
   
    func createtransaction(fromAdress:String,toAdress:String,amount:String){
            var request = URLRequest(url: URL(string: "http://localhost:3000/transactions/createTransaction")!)
            request.httpMethod = "post"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
            let postString = "fromAdress="+fromAdress+"&"+"toAdress="+toAdress+"&"+"amount="+amount+"&"
          
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error?.localizedDescription))")
                    return
                }

                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }

                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")

                if(responseString?.contains("true"))!{
                    print("status = true")
                }
                else{
                    print("Status = false")
                }
            }

            task.resume()
        }
}
