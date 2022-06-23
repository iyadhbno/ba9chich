//
//  expenseviewmodel.swift
//  ba9chich
//
//  Created by User on 23.06.2022.
//

import Foundation

class expenseVM {
    var AllExpenses = [Expense]()
    func getallExpenses()  {
       
        
        let jsonUrlString = "http://localhost:3000/getreponsesid/"
            guard let url = URL(string: jsonUrlString) else
            { return }

            URLSession.shared.dataTask(with: url) { (data, response, err) in

                guard let data =  data else{ return }

                do {
                    self.AllExpenses.removeAll()

                    let reponses = try JSONDecoder().decode([Expense].self, from: data)
                 
                    reponses.forEach { user in self.AllExpenses.append(user) }
                    
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }

            }.resume()
    }
    
    
   
    func createexpense(item:String,price:String,userId:String){
            var request = URLRequest(url: URL(string: "http://localhost:3000/createreponse")!)
            request.httpMethod = "post"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
            let postString = "item="+item+"&"+"price="+price+"&"+"userId="+userId+"&"
          
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
