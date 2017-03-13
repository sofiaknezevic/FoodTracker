//
//  SignUpViewController.swift
//  FoodTracker
//
//  Created by Sofia Knezevic on 2017-03-13.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate
{
    

    //MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    
    let apiURL = URL(string: "http://159.203.243.24:8000")!
    
    //MARK: Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        warningLabel.isHidden = true

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
        
    }

    
    //MARK: Actions
    @IBAction func saveUserInfo(_ sender: UIButton)
    {
        
        guard
            let password = passwordTextField.text
            else
        {
            
            warningLabel.text = "This is not a valid password."
            warningLabel.isHidden = false
            return
            
        }
        
        guard
            let userName = usernameTextField.text
            else
        {
            
            warningLabel.text = "This is not a valid username."
            warningLabel.isHidden = false
            return
        }
        
        guard
            password.characters.count > 7
            else
        {
            
            warningLabel.text = "Your password must be 8 characters or more."
            warningLabel.isHidden = false
            return
            
        }
        
        print("Username: \(userName) Password: \(password)")
        
        self.dismiss(animated: true, completion: nil)
        
        let postData = ["username": usernameTextField.text ?? "",
                        "password": passwordTextField.text ?? ""]
        
        guard
            let postForJSON = try?
                JSONSerialization.data(withJSONObject: postData,
                                       options: JSONSerialization.WritingOptions.prettyPrinted)
            else
        {
            
            print("could not serialize JSON")
            return
            
        }
        
        let signUpURL = URL(string: "http://159.203.243.24:8000/signup")!
        
        let request = NSMutableURLRequest(url:signUpURL)
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
            
            let newUserDefaults = UserDefaults.standard
            newUserDefaults.set(json?["user"], forKey: "user")
            newUserDefaults.synchronize()
            
            
            self.dismiss(animated: true, completion: nil)
        }
        
        task.resume()
        
    }
    
    

}
