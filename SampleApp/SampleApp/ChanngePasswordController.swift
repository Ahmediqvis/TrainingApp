//
//  ChanngePasswordController.swift
//  SampleApp
//
//  Created by IQVIS on 11/11/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//

import UIKit




class ChangePasswordController: UIViewController,GetStatusCodeDelegate {
    
    @IBOutlet weak var userNewPass: UITextField!
    @IBOutlet weak var userConfirmPass: UITextField!
    
    var model:NSDictionary = [:]
    var check:Bool=true
   func getUserModel(data: NSDictionary){
        model = data
        DispatchQueue.main.async {
            if(self.model[RequestCode.REQUESTERROR]! as! String == "false")
            {
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                self.navigationController?.isNavigationBarHidden=true
                self.navigationController?.pushViewController(viewController, animated:true)
                
            }else{
                let alert = UIAlertController(title: "Alert", message: self.model[RequestCode.REQUESTMESSAGE]! as? String, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
            }
            
        }
        
        
        

    }
    func getErrorInRequest(flag: Bool) {
        check=flag
    }


      
    @IBAction func updatePassword(_ sender: UIButton) {
        if(userNewPass.text! == userConfirmPass.text!)
        {
            let USERINFO=Info.UserData
           print(USERINFO.userId)
            let postParams = ["userId":USERINFO.userId, "password":userNewPass.text!,"deviceID":"1","deviceType":"2"]as Dictionary<String, String>
            ApiManager.sharedInstance.delegate=self
            ApiManager.sharedInstance.postRequest(path: APIConstants.CHANGEPASSWORD, postParams: postParams)
            //print(model!.error)
            
        }

    }
    
    override func viewDidLoad() {
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
