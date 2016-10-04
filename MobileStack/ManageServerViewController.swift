//
//  ManageServerViewController.swift
//  MobileStack
//
//  Created by Michael Brewer on 10/4/16.
//
//

import UIKit

class ManageServerViewController: UIViewController {
    var serverName = ""
    var serverId = ""
    
    @IBOutlet weak var labelTest: UILabel!
    @IBOutlet weak var otherText: UILabel!
    @IBAction func StartServer(_ sender: AnyObject) {
        print(self.serverName)
        print(self.serverId)
    }
    @IBAction func StopServer(_ sender: AnyObject) {
        print(self.serverName)
        print(self.serverId)
    }
    @IBAction func RestartServer(_ sender: AnyObject) {
        print(self.serverName)
        print(self.serverId)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.labelTest.text = "\(serverName)"
        self.otherText.text = "\(serverId)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ManageServer" {
            
        }
    }*/
 

}
