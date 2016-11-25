//
//  ViewController.swift
//  SampleApp
//
//  Created by IQVIS on 11/10/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//

import UIKit

class HomeController: UIViewController, GetStatusCodeDelegate{
    
   
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var UserEmail: UITextField!
   

    var model:NSDictionary = [:]
    var check:Bool=true
    
    func getUserModel(data: NSDictionary) {
        model = data
        
        DispatchQueue.main.async {
            self.progressIndicator.stopAnimating()
            self.writeTofile(data: self.model)
            let rModel = ResponseModel(data: self.readModel() )
            
            if(rModel.error == "false" && rModel.status == RequestCode.SUCCESCODE)
            {
                self.writeTofile(data: self.model)
                UserDefaults.standard.set(true, forKey: "logged In")
                self.setModel(model: rModel.userModel)
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: SWREVEAL) as! SWRevealViewController
                self.navigationController?.isNavigationBarHidden=true
                self.navigationController?.pushViewController(viewController, animated:true)
            }
        
        }
    }
    func readModel()->NSDictionary{
    let file = "file.txt"
        var dictionary:NSDictionary?
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            
            //reading
            do {
                let weatherData = NSData(contentsOf: path)
                dictionary = NSKeyedUnarchiver.unarchiveObject(with: weatherData as! Data) as! [String : Any] as NSDictionary?
                
            }
            catch {/* error handling here */}
            
        }
        return dictionary!
        
    
    }
    func writeTofile(data:NSDictionary)
    {
       let file = "file.txt" //this is the file. we will write to and read from it
        
       // let text = "some text" //just a text
        let userInformation: Data = NSKeyedArchiver.archivedData(withRootObject: data)
        print(userInformation)
               let dictionary: NSDictionary? = NSKeyedUnarchiver.unarchiveObject(with: userInformation) as! [String : Any] as NSDictionary?
        print(dictionary!)
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try userInformation.write(to: path, options: .atomic)
            }
            catch {/* error handling here */}
        }
        
    }
    
    func getErrorInRequest(flag: Bool) {
        check=flag
    }
    
    
    @IBAction func goToHome(_ sender: UIButton)
    {
    
        print(userPassword.text!)
        print(UserEmail.text!)
        let postParams = ["username":UserEmail.text!,"password":userPassword.text!]as Dictionary<String, String>
        
        if(ValidationUtility.isConnectedToNetwork() == false)
        {
            showalert(message:MessageError.NETWORKISSUE)
        }
        else
        {
            if(userPassword.text!.isEmpty || UserEmail.text!.isEmpty)
            {
            showalert(message: MessageError.EMPTYMESSAGE)

            }
            else
            {
                
                progressIndicator.startAnimating()
                ApiManager.sharedInstance.delegate=self
                ApiManager.sharedInstance.postRequest(path: APIConstants.LOGINACCOUNT, postParams: postParams)
           
        }
        }
        
        
        
    
    
    }
  
    func showalert(message:String)
    {
        
        let alert = UIAlertController(title: "Alert", message:message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func setModel(model:UserModel!)
    {
        let USERINFO=Info.UserData
        USERINFO.gender=model.gender
        USERINFO.address=model.address
        USERINFO.contact=model.contact
        USERINFO.dob=model.dob
        USERINFO.email=model.email
        USERINFO.firstName=model.firstName
        USERINFO.lastName=model.lastName
        USERINFO.image=model.image
        USERINFO.userId=model.userId
        
    }
       @IBAction func registerAccount(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        self.navigationController?.pushViewController(viewController, animated:true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //progressIndicator.startAnimating()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


