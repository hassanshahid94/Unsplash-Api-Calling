//
//  ServerManager.swift
//  KiskoLabsTask
//
//  Created by Hassan Shahid on 11/06/2020.
//  Copyright © 2020 Hassan Shahid. All rights reserved.
//

import Foundation
import Alamofire

class ServerManager {
    
    public static func getPhotos(page: String, query: String, completion: @escaping (String,KiskoLabsFoodResponse?) -> Void)
    {
        let url = "\(Constants.BaseURL)\(KiskoLabsAPIEndpoints.getPhotos.rawValue)page=\(page)&query=\(query)"
        
        let header = ["Authorization": Constants.sceretKey]
        
        Alamofire.request(url, method: .get, parameters: nil, headers: header)
            .responseJSON { response in
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                        
                    case 200: //success
                        //to get JSON return value
                        if let result = response.data {

                           let decoder = JSONDecoder()
                            do {
                                let foodData = try decoder.decode(KiskoLabsFoodResponse.self, from: result)
                            
                                completion("success", foodData)
                                
                            } catch {
                                completion("Something went wrong.", nil)
                                
                            }
                            
                        }
                    case 400:  // query is missing
                        
                        completion("Query is missing.", nil)
                        
                    case -1009:
                        
                         completion("The Internet connection appears to be offline.", nil)
                        
                    default:
                        completion("Something went wrong. Please try again.",nil)
                    }
                } else {
                    completion((response.error?.localizedDescription)!, nil)
                }
        }
    }
}

enum KiskoLabsAPIEndpoints: String
{
    //Rest API URL
    case getPhotos             = "search/photos?"
}
