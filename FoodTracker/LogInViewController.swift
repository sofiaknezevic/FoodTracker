//
//  LogInViewController.swift
//  FoodTracker
//
//  Created by Sofia Knezevic on 2017-03-13.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    
    let newCloudTracker = CloudTrackerAPI()
    let urlString = "login"

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        guard
            let password = passwordTextField.text
            else
        {
      
            return
            
        }
        
        guard
            let userName = usernameTextField.text
            else
        {
            return
        }
        
        guard
            password.characters.count > 7
            else
        {
            
            return
            
        }
        let postData = ["username": userName,
                        "password": password]
        
        newCloudTracker.postNetworkInformation(stringForJSON: postData, stringForURL: urlString)

        performSegue(withIdentifier: "showMeals", sender: self)
        
    }

}
