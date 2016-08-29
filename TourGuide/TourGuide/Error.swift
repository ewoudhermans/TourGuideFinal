//
//  Error.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 13/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import Foundation

enum Error: ErrorType {
    case EmptyField
    case PasswordsDoNotMatch
    case InvalidEmail
    case UserNameTaken
    case IncorrectSignIn
}

extension Error: CustomStringConvertible {
    var description: String {
        switch self {
        case .EmptyField: return "Please fill in al the fields"
        case .PasswordsDoNotMatch: return "Passwords do not match"
        case .InvalidEmail: return "Entered email is not valid"
        case .UserNameTaken: return "Username already taken"
        case .IncorrectSignIn: return "Sign in is incorrect"
        }
    }
}