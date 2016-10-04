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
    var serverStatus = ""
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBAction func StartServer(_ sender: AnyObject) {
        startServer(serverId: self.serverId)
        // create the alert
        let alert = UIAlertController(title: "\(self.serverName)", message: "Starting Server...", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func StopServer(_ sender: AnyObject) {
        stopServer(serverId: self.serverId)
        // create the alert
        let alert = UIAlertController(title: "\(self.serverName)", message: "Stopping Server...", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func RestartServer(_ sender: AnyObject) {
        rebootServer(serverId: self.serverId)
        // create the alert
        let alert = UIAlertController(title: "\(self.serverName)", message: "Rebooting Server...", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.labelTitle.text = "\(serverName)"
        self.labelId.text = "\(serverId)"
        self.statusLabel.text = "\(serverStatus)"
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
