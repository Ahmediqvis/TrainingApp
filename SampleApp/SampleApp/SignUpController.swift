//
//  SignUpController.swift
//  SampleApp
//
//  Created by IQVIS on 11/10/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//

import UIKit


class SignUpController: UIViewController,GetStatusCodeDelegate {
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userName: UITextField!
    var model:NSDictionary = [:]
    var check:Bool=true
    func getErrorInRequest(flag: Bool) {
        check=flag
    }
     func getUserModel(data: NSDictionary) {
       model = data
        DispatchQueue.main.async {
            if(self.model[RequestCode.REQUESTERROR]! as! String == "true")
            {
                print(self.model[RequestCode.REQUESTMESSAGE]!)
            }
            else{
                let rModel = ResponseModel(data: self.model )
                self.setModel(model: rModel.userModel)
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                self.navigationController?.isNavigationBarHidden=true
                self.navigationController?.pushViewController(viewController, animated:true)
             }
        }
    }
    @IBAction func registerAccount(_ sender: UIButton)
    {
        
        if(ValidationUtility.isValidEmail(testStr: userEmail.text!)==true)
        {
            if(userName.text!.isEmpty || userPassword.text!.isEmpty)
            {
                showalert(message: "REquired Field error")
            }
            else{
                
                
                let postParams = ["userName":userName.text!,"email":userEmail.text!, "password":userPassword.text!,"deviceID":"1","deviceType":"2"]as Dictionary<String, String>
                ApiManager.sharedInstance.delegate=self
                ApiManager.sharedInstance.postRequest(path: APIConstants.REGISTERACCOUNT, postParams: postParams)
               
             
            }
        }
        else{
            
                showalert(message: "Email is not valid!try again")
            
            }
        
            
        
       /*
        if(code == 409)
        {
            let alert = UIAlertController(title: "Alert", message: "Required field error", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if(code==400)
        {
            let alert = UIAlertController(title: "Alert", message: "Already created!Please enter with other username", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        }else if(code == 500)
        {
            let alert = UIAlertController(title: "Alert", message: "Oops! An error occurred while registering", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.navigationController?.isNavigationBarHidden=true
            self.navigationController?.pushViewController(viewController, animated:true)
        
        }
    */
    }
    func setModel(model:UserModel!)
    {
        let USERINFO=Info.UserData
        USERINFO.gender=model.gender
        USERINFO.address=model.address
        USERINFO.status="logged IN"
        USERINFO.contact=model.contact
        USERINFO.dob=model.dob
        USERINFO.email=model.email
        USERINFO.firstName=model.firstName
        USERINFO.lastName=model.lastName
        USERINFO.image=model.image
        USERINFO.userId=model.userId
        /*
         
         USERINFO.setemail(email: model!.userModel.email)
         USERINFO.setfirstName(fname: model!.userModel.firstName)
         USERINFO.setlastName(lname: model!.userModel.lastName)
         USERINFO.setuserId(userId: model!.userModel.userId)
         
         USERINFO.setimageurl(image: model!.userModel.image)
         USERINFO.setoccupation(occupation: model!.userModel.occupation)
         USERINFO.setaddress(address: model!.userModel.address)
         USERINFO.setdob(dob:model!.userModel.dob)
         USERINFO.setcurrentstatus(status: "logged in")
         */
    }

    func showalert(message:String)
    {
        
        let alert = UIAlertController(title: "Alert", message:message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
