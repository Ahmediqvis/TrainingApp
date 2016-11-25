//
//  ValidationUtility.swift
//  SampleApp
//
//  Created by IQVIS on 11/17/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//

import Foundation
import SystemConfiguration

class ValidationUtility{

    static func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    static func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
        
    }
    static func convertImageToBase64(image: UIImage) -> String {
        
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
        //imageData?.base64EncodedStringWithOptions(NSData.Base64EncodingOptions.Encoding64CharacterLineLength)
        
        return base64String!
        
    }
    static func convertBase64ToImage(base64String: String) -> UIImage {
        
        //let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        let data: NSData = NSData(base64Encoded: base64String , options: .ignoreUnknownCharacters)!
        let dataImage = UIImage(data: data as Data)
        //let decodedimage = UIImage(data: decodedData! as Data)
        
        return dataImage!
        
    }
   



}
