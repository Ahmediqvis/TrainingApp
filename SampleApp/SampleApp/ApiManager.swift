//
//  ApiManager.swift
//  SampleApp
//
//  Created by IQVIS on 11/15/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//


import Foundation



protocol GetStatusCodeDelegate{

    func getUserModel(data:NSDictionary)
    func getErrorInRequest(flag:Bool)

}



class ApiManager{
    
    var delegate:GetStatusCodeDelegate?
    
    static let sharedInstance = ApiManager()
        
    private init()
    {
    }
    
    public func getRequest(path: String)
    {
        makeHTTPGetRequest(path: path)
    }
    public func postRequest(path: String, postParams: Dictionary<String,String>)
    {
        makeHTTPPostRequest(path: path, postParams: postParams)
        
        
    }
       // MARK: Perform a POST Request
    private func makeHTTPPostRequest(path: String, postParams: Dictionary<String,String>){
        // Setup the session to make REST POST call
        let postEndpoint: String = path
        let url = NSURL(string: postEndpoint)!
        
        
        // Create the request
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = POSTTYPE
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postParams, options: .prettyPrinted)
            print(postParams)
        } catch {
            print("bad things happened")
        }
        //let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                self.delegate?.getErrorInRequest(flag: false)
                //semaphore.signal()
                return
              
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as? NSDictionary
               // let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
            
               // let rModel = ResponseModel(data: result! )

                self.delegate?.getUserModel(data: result!)
                
                print("result --> \(result)")
                
            
            } catch {
                print("Error -> \(error)")
                
            }
           // semaphore.signal()
        }
        task.resume()
        //delegate?.getStatusCode(data:code)
       // _ = semaphore.wait(timeout: .distantFuture)
 
        
    }
    // MARK: Perform a GET Request
    private func makeHTTPGetRequest(path: String) {
        let postEndpoint: String = path
        let url = NSURL(string: postEndpoint)!
        print("url->\(url)")
        // Create the request
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }else{
                
                let status = (response as! HTTPURLResponse).statusCode
                print("status code is \(status)")
                // 200? Yeah authentication was successful
                
            }
        }
        task.resume()
    }

}


/*
    private func connection(_ connection: NSURLConnection, didReceive response: URLResponse)
    {
        //let status = (response as! HTTPURLResponse).statusCode
        //println("status code is \(status)")
        // 200? Yeah authentication was successful
    }
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        //Handle error
    }
    
    private func connection(_ connection: NSURLConnection, didReceive data: Data){
        dataVal.append(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!)
    {
        
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: dataVal as Data, options: []) as? NSDictionary {
                print(jsonResult)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    func connection(_ connection: NSURLConnection, willSendRequestFor challenge: URLAuthenticationChallenge) {
        if challenge.previousFailureCount > 1 {
            
        } else {
            let creds = URLCredential(user: "ahmed", password: "123", persistence: URLCredential.Persistence.none)
            challenge.sender?.use(creds, for: challenge)
            
        }

    }

    func initialzeConnection()
    {
        
        let username = "user"
        let password = "pass"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        // create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        // fire off the request
        // make sure your class conforms to NSURLConnectionDelegate
        let urlConnection = NSURLConnection(request: request, delegate: self)
        
        urlConnection?.start()
        
 
    }
 
     
     // MARK: Perform a GET Request
     private func makeHTTPGetRequest(path: String) {
     let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
     
     let session = URLSession.shared
     
     let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
     if let jsonData = data {
     
     } else {
     
     }
     })
     task.resume()
     }
     
     // MARK: Perform a POST Request
     private func makeHTTPPostRequest(path: String, body: [String: AnyObject]) {
     let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
     
     // Set the method to POST
     request.httpMethod = "POST"
     
     do {
     // Set the POST body for the request
     let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
     request.httpBody = jsonBody
     let session = URLSession.shared
     
     let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
     if let jsonData = data {
     
     } else {
     
     }
     })
     task.resume()
     } catch {
     // Create your personal error
     // onCompletion(nil, nil)
     }
     }
     */
    

