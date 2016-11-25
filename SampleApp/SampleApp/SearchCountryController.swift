//
//  SearchCountryController.swift
//  SampleApp
//
//  Created by IQVIS on 11/11/16.
//  Copyright © 2016 IQVIS. All rights reserved.
//


protocol GetCountryDelegate
{
    func getSelectCountry(name:String)
 
    
}

class SearchCountryController: UIViewController ,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var searchCountry: UISearchBar!
    @IBOutlet weak var listCountries: UITableView!
    var delegate:GetCountryDelegate?
    var searchActive : Bool = false
    var data = ["Pakistan","India","China","Bangladesh","U.A.E","Australia","America"]
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup delegates */
        listCountries.delegate = self
        listCountries.dataSource = self
        searchCountry.delegate = self
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //print(filtered[indexPath.row])
        if(filtered.count==0)
        {
            print(data[indexPath.row])
            delegate?.getSelectCountry(name: data[indexPath.row])
        }
        else{
            print(filtered[indexPath.row])
            delegate?.getSelectCountry(name: filtered[indexPath.row])
        }
        self.dismiss(animated: true, completion:{})
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.listCountries.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listCountries.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row];
        }
        
        return cell;
    }
    
}
