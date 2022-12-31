//
//  WebService.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 19/12/22.
//

import Foundation
import UIKit

class WebService {
     
    func call(with urlString: String, httpMethod: String, httpBody: [String: Any]?, completion: @escaping ((Data?)->())){
        guard let url = URL(string: urlString) else{
            print("invalid url")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        let headers = ["Content-Type" : "application/json"]
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = httpMethod
        
        if let httpBody = httpBody {
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: httpBody, options: .fragmentsAllowed)
                request.httpBody = requestBody
            } catch{
                print("error to encode json")
                completion(nil)
                return
            }
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request){ data, responce, error in
           
            if let data, let jsonParsing = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(jsonParsing)
            }
                
            completion(data)
            
            if let string = String(bytes: data!, encoding: .utf8) {
                print(string)
            } else {
                print("not a valid UTF-8 sequence")
            }
            
        }
        
        dataTask.resume()
    }
}
