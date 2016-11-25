//
//  ResponseModel.swift
//  SampleApp
//
//  Created by IQVIS on 11/17/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//

class ResponseModel {
    
    var status : String
    var message : String
    let error : String
    
    let userModel: UserModel
    
    
    init(data: NSDictionary){
        
        
        self.status=data[RequestCode.REQUESTCODE]! as! String
        self.message=data[RequestCode.REQUESTMESSAGE]! as! String
        self.error = data[RequestCode.REQUESTERROR]! as! String

        
        self.userModel = UserModel(user:data[UserCode.USER]! as! NSDictionary )
        
        
    
        //let userdata=try JSONSerialization.jsonObject(with: data[USER]!, options: []) as? [String:AnyObject]
        //self.userModel = UserModel(user:data[USER]! as! Dictionary<String, AnyObject> )
    }
}
