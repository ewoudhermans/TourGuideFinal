//
//  SignUp.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 12/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import Foundation
import Parse
import Bolts

class SignUp: NSObject {
    
    var firstName: String?
    var lastName: String?
    var userName: String?
    var userEmail: String?
    var userPassword: String?
    var confirmPassword: String?

    init(fName: String, lName: String, uName: String, uEmail: String, uPassword: String, cPassword: String) {
        
        self.firstName = fName
        self.lastName = lName
        self.userName = uName
        self.userEmail = uEmail
        self.userPassword = uPassword
        self.confirmPassword = cPassword
    }
    
    func checkRequirements() throws {
        if firstName!.isEmpty && lastName!.isEmpty && userName!.isEmpty && userEmail!.isEmpty && userPassword!.isEmpty && confirmPassword!.isEmpty {
            throw Error.EmptyField
        }
        let email = "[A-Z0-9a-z+-._%]+@[A-Za-z]+\\.[A-Za-z]{2-4}"
        let range = userEmail!.rangeOfString(email, options: .RegularExpressionSearch)
        let result = range != nil ? true : false
        if result == true {
            throw Error.InvalidEmail
        }
        
        if (userPassword! != confirmPassword!) {
            throw Error.PasswordsDoNotMatch
        }
    }
    
    func storeNewUser(completion:(result: PFUser?, succes: Bool) -> Void) {
        
        let user = PFUser()
        
        user["Firstname"] = firstName!
        user["Lastname"] = lastName!
        user.username = userName!
        user.email = userEmail!
        user.password = userPassword!
        
        user.signUpInBackgroundWithBlock({(success: Bool, error: NSError?) -> Void in
            if success {
                completion(result: PFUser.currentUser()!, succes: true)
            } else {
                completion(result: nil, succes: false)
            }
        })
    }
}
