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
        
        
        //MARK: Network request stuff
        print("Username: \(userName) Password: \(password)")
        
        self.dismiss(animated: true, completion: nil)
        
        let postData = ["username": usernameTextField.text ?? "",
                        "password": passwordTextField.text ?? ""]
        
        let signUpString = "signup"
        

        newCloudTracker.getNetworkInformation(stringForJSON: postData, andStringForURL: signUpString)
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logInPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "showLogIn", sender: self)
        
    }
    

}
