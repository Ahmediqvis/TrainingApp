//
//  MenuTableViewController.swift
//  SampleApp
//
//  Created by IQVIS on 11/10/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
       
        TableArray = ["Home","Profile","Change Password","Log out"]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        return cell
    }
     
}
