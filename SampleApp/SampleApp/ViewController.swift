//
//  ViewController.swift
//  SampleApp
//
//  Created by IQVIS on 11/10/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var open: UIBarButtonItem!
    
    @IBOutlet weak var userDescription: UITextView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        open.target = self.revealViewController()
        open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        let rModel = ResponseModel(data: self.readModel() )
        self.setModel(model: rModel.userModel)
        let USERINFO=Info.UserData
        userName.text=USERINFO.firstName
        userEmail.text=USERINFO.email
        userDescription.text=UserDumyData.DESCRIPTION
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
}

