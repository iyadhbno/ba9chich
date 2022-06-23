//
//  transaction.swift
//  ba9chich
//
//  Created by User on 23.06.2022.
//

import Foundation


struct Transaction : Decodable{
    
    let _id : String?
    let fromAdress : String?
    let toAdress : String?
    let amount : String?
    private  enum CodingKeys: String, CodingKey {
     
          case _id, fromAdress,toAdress,amount
       }
      
   
   
}
