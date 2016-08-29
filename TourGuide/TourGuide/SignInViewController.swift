//
//  SignInViewController.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 12/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var noUserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.opaque = true
        // Do any additional setup after loading the view.
        signInButton.layer.cornerRadius = 8
        noUserButton.layer.cornerRadius = 8
    }

    @IBAction func signInTouched(sender: AnyObject) {
        let signin = SignIn(user: userName.text!, pass: userPassword.text!)
        
        do {
            // call signIn model function SignInUser()
            // anything under this try will execute if signInUser returns true
            try signin.signInUser()
            performSegueWithIdentifier("mainView", sender: self)
            // dismiss view controller and go to MainViewController
//            self.dismissViewControllerAnimated(true, completion: nil)
            
            // catches error thrown by SignInUser() if there is one
        } catch let error as Error {
            print(error.description)
        } catch {
            print("Sorry something went\n wrong please try again")
        }
    }
    
    @IBAction func SignUp(sender: AnyObject) {
        performSegueWithIdentifier("SignInToSignUp", sender: self)
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
