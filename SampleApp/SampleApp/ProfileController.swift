//
//  ProfileController.swift
//  SampleApp
//
//  Created by IQVIS on 11/11/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//

import UIKit


class ProfileController: UIViewController, GetStatusCodeDelegate,GetCountryDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var editbutton: UIButton!
    
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userOccupation: UITextField!
    @IBOutlet weak var userGender: UITextField!
    @IBOutlet weak var userDob: UITextField!
    @IBOutlet weak var userNumber: UITextField!
    @IBOutlet weak var userAddress: UITextView!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    //let user=UserInfo.UserData;
    @IBOutlet weak var userSelectedCountry: UILabel!
    var countryName:String=""
    let VU=ValidationUtility()
    var model:NSDictionary = [:]
    var check:Bool=true
    
     func getUserModel(data: NSDictionary)  {
        model = data
        DispatchQueue.main.async {
        let rModel = ResponseModel(data: self.model )
            if(rModel.error == "false" && rModel.status == RequestCode.SUCCESCODE)
            {
               self.setModel(model: rModel.userModel)
                
                
                
            }else{
                let alert = UIAlertController(title: "Alert", message: rModel.message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            self.updateButton.isEnabled=false
            self.setStatus(status:false)
            self.editbutton.isEnabled=true
        }
    }
    func getErrorInRequest(flag: Bool) {
        check=flag
    }
    func getSelectCountry(name: String) {
        userSelectedCountry.text!=name
    }
 
    @IBAction func editbutton(_ sender: UIButton) {
        updateButton.isEnabled=true
        updateButton.setTitle("Update", for: UIControlState.normal)
        setStatus(status:true)
        editbutton.isEnabled=false
        editbutton.setTitle(" ", for: UIControlState.normal)
    }

    func setStatus(status:Bool)
    {
        
        userEmail.isEnabled=status
    
        userOccupation.isEnabled=status
        
        userGender.isEnabled=status
       
        userDob.isEnabled=status
        
        firstName.isEnabled=status
      
        lastName.isEnabled=status
        
        userAddress.isEditable=status
    
        userNumber.isEnabled=status
    
    }
    
    @IBAction func profileUpdate(_ sender: UIButton) {
        let USERINFO=Info.UserData
        print(USERINFO.userId)
        let postParams = ["userId":USERINFO.userId,"firstName":firstName.text!,"lastName":lastName.text!,"address":userAddress.text!,"contactNo":userNumber.text!,"dob":userDob.text!,"gender":userGender.text!,"occupation":userOccupation.text!,"email":userEmail.text!,"image":" "]as Dictionary<String, String>
        ApiManager.sharedInstance.delegate=self
        ApiManager.sharedInstance.postRequest(path: APIConstants.UPDATEPROFILE, postParams: postParams)
               

    }
   

    @IBAction func coutryList(_ sender: UIButton)
    {
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchCountryController") as! SearchCountryController
        viewController.delegate=self

        self.present(viewController, animated: true )
        
        //userSelectedCountry.text!=countryName
        
        
    }
    
    override func viewDidLoad() {
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
       
        settextfield()
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(img:)))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGestureRecognizer)
        updateButton.isEnabled=false
        updateButton.setTitle(" ", for: UIControlState.normal)
        
    }
    func imageTapped(img: AnyObject)
    {
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(ImagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userImage.image = image
            let temp=ValidationUtility.convertImageToBase64(image: image)
            let tempimage=ValidationUtility.convertBase64ToImage(base64String: temp)
            testImage.image = tempimage
            //print(VU.convertImageToBase64(image: image))
        } else{
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func settextfield()
    {
        let USERINFO=Info.UserData
        userEmail.text=USERINFO.email
        userOccupation.text=USERINFO.occupation
        userGender.text=USERINFO.gender
        userDob.text=USERINFO.dob
        firstName.text=USERINFO.firstName
        lastName.text=USERINFO.lastName
        userAddress.text=USERINFO.address
        userNumber.text=USERINFO.contact
        setStatus(status:false)

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
        settextfield()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
