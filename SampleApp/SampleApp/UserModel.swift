//
//  UserModel.swift
//  SampleApp
//
//  Created by IQVIS on 11/17/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//

class UserModel {
    
    var userId : String
    var firstName: String
    var lastName: String
    var address : String
    var contact: String
    var email: String
    var dob: String
    var gender:String
    var occupation:String
    var image:String
    
    
    
    init(user: NSDictionary){
        self.firstName = user[UserCode.FNAME]! as! String
        self.lastName = user[UserCode.LNAME]! as! String
        self.image = user[UserCode.IMAGE]! as! String
        self.occupation = user[UserCode.OCCUPATION]! as! String
        self.gender = user[UserCode.GENDER]! as! String
        self.dob = user[UserCode.DOB]! as! String
        self.address = user[UserCode.ADDRESS]! as! String
        self.email = user[UserCode.EMAIL]! as! String
        self.userId = user[UserCode.USERID]! as! String
        self.contact = user[UserCode.CONTACT]! as! String
    }
}
