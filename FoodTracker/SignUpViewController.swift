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
    
    
    let newCloudTracker = CloudTrackerAPI()
    let signUpString = "signup"
    
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
        
        self.dismiss(animated: true, completion: nil)
        
        let postData = ["username": userName,
                        "password": password]

        newCloudTracker.postNetworkInformation(stringForJSON: postData, stringForURL: signUpString)

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logInPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "showLogIn", sender: self)
        
    }
    

}
