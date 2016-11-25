import UIKit

class CompleteMenuController: UIViewController, ENSideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        self.sideMenuController()?.sideMenu?.delegate = self


        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
