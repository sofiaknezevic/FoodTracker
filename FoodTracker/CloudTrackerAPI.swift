//
//  CloudTrackerAPI.swift
//  FoodTracker
//
//  Created by Sofia Knezevic on 2017-03-13.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class CloudTrackerAPI: NSObject {
    
    let apiURL = URL(string: "http://159.203.243.24:8000")!
    
    func getNetworkInformation(stringForJSON: [String: String], andStringForURL:String) -> Void
    {
        
        let newUserDefaults = UserDefaults.standard
        
        let postForJSON = try? JSONSerialization.data(withJSONObject: stringForJSON, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let request = NSMutableURLRequest(url:apiURL.appendingPathComponent(andStringForURL))
        request.httpBody = postForJSON
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {
            (data: Data?, response: URLResponse?, error: Error?) in
            guard
                let data = data
                else
            {
                print("no data return from server \(error?.localizedDescription)")
                return
            }
            
            guard
                let responseToURL = response as? HTTPURLResponse
                else
            {
                print("no response returned from server \(error)")
                return
            }
            
            guard
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String,Dictionary<String,String>>
                else
            {
                
                print("data returned is not json, or not valid")
                return
                
            }
            
            
            
            guard
                responseToURL.statusCode == 200
                else
            {
                
                print("an error occurred \(json?["error"])")
                return
                
            }
            
            newUserDefaults.set(json?["user"], forKey: "user")
            newUserDefaults.synchronize()

            
        }
        
        task.resume()
        

    }
    

}
