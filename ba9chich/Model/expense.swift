//
//  expense.swift
//  ba9chich
//
//  Created by User on 23.06.2022.
//

import Foundation


struct Expense : Decodable{
    
    let _id : String?
    let item : String?
    let price : String?
    let userId : String?
    private  enum CodingKeys: String, CodingKey {
     
          case _id, item,price,userId
       }
      
   
   
}
