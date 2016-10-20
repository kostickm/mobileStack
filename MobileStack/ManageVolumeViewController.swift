/**
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import UIKit

class ManageVolumeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var volumeName = ""
    var volumeId = ""
    var volumeStatus = ""
    var volumeSize = ""
    var servers = [Server]()
    var serverName:String = ""
    var serverId:String = ""

    @IBOutlet weak var volumeIdLabel: UILabel!
    @IBOutlet weak var volumeSizeLabel: UILabel!
    @IBOutlet weak var volumeStatusLabel: UILabel!
    @IBOutlet weak var volumeNameLabel: UILabel!
    @IBOutlet weak var serverPickerView: UIPickerView!
    
    // TODO: Attach volume to server
    @IBAction func attachVolumeButton(_ sender: AnyObject) {
        
        attachVolumeToServer(serverId: self.serverId, volumeId: self.volumeId)
        
        let alert = UIAlertController(title: "\(self.volumeName)", message: "Attaching Volume...", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func detachVolumeButton(_ sender: AnyObject) {
        listVolumeAttachments(serverId: self.serverId) { attachmentList in
            
            //TODO: Create loop over array of attachment IDs then attach the currently selected volumeId
            
            for (_, item) in attachmentList.enumerated() {
                if self.volumeId == item.volumeId {
                    detachVolumeToServer(serverId: self.serverId, volumeId: self.volumeId, attachment: item.id!)
                }
            }
        }
        
        let alert = UIAlertController(title: "\(self.volumeName)", message: "Detaching Volume...", preferredStyle: UIAlertControllerStyle.alert)
        
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
        
        getServers { servers in
            self.servers = servers
            DispatchQueue.main.async(execute: { () -> Void in
                self.serverName = servers[0].name!
                self.serverId = servers[0].id!
                self.serverPickerView.delegate = self
                self.serverPickerView.dataSource = self
            })
        }
        
        self.volumeIdLabel.text = "\(volumeId)"
        self.volumeNameLabel.text = "\(volumeName)"
        self.volumeSizeLabel.text = "Size: \(volumeSize)GB"
        self.volumeStatusLabel.text = "Status: \(volumeStatus)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        
        var count = 0
        if pickerView == serverPickerView {
            count = servers.count
        }
        
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Helvetica", size: 12)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        if pickerView == serverPickerView {
            pickerLabel?.text = servers[row].name
            pickerLabel?.textColor = UIColor.white
        }
        
        return pickerLabel!;
        
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if pickerView == serverPickerView {
            self.serverName = servers[row].name!
            self.serverId = servers[row].id!
        }
        
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if attachVolumeButton === sender as AnyObject? {
            let name = serverNameTextField.text ?? ""
            
            // Set the server to be passed to ServerTableViewController after the unwind segue.
            print(volumeId)
            createServer(name: name, imageId: imageId, flavorId: flavorId)
        }
    }*/
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
