//
//  Constants.swift
//  SampleApp
//
//  Created by IQVIS on 11/16/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//

import Foundation
struct APIConstants {
   static let baseurl = "http://napidev2.nvolv.co:7003/"
   static let REGISTERACCOUNT = baseurl+"RegisterUser"
   static let LOGINACCOUNT = baseurl+"Login"
   static let CHANGEPASSWORD = baseurl+"ChangePassword"
   static let UPDATEPROFILE = baseurl+"UpdateUserProfile"
}

let POSTTYPE="POST"
struct RequestCode{
    static let REQUESTCODE="code"
    static let REQUESTMESSAGE="message"
    static let REQUESTERROR="error"
    static let SUCCESCODE="201"
}
struct UserCode{
    static let USER="user"
    static let FNAME="firstName"
    static let LNAME="firstName"
    static let IMAGE="image"
    static let EMAIL="email"
    static let USERID="userId"
    static let OCCUPATION="occupation"
    static let ADDRESS="address"
    static let CONTACT="contact"
    static let DOB="dob"
    static let GENDER="gender"
}
struct MessageError{
    static let EMPTYMESSAGE="Required Field Error"
    static let NETWORKISSUE="Internet is not coonected"
}
//let USERINFO=UserInfo.UserData
struct UserDumyData{
    static let DESCRIPTION="Dummy description"
}
let SWREVEAL = "SWRevealViewController"
//let VU=ValidationUtility()
