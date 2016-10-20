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

class ManageServerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var serverName = ""
    var serverId = ""
    var serverStatus = ""
    
    var attachedVolumes = [Attach]()

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var attachmentPickerView: UIPickerView!
    
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
        
        listVolumeAttachments(serverId: serverId) { attachments in
            DispatchQueue.main.async(execute: { () -> Void in
                self.attachedVolumes = attachments
                self.attachmentPickerView.delegate = self
                self.attachmentPickerView.dataSource = self
            })
        }
        self.labelTitle.text = "\(serverName)"
        self.labelId.text = "\(serverId)"
        self.statusLabel.text = "\(serverStatus)"
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
        
        return self.attachedVolumes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Helvetica", size: 12)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        if pickerView == attachmentPickerView {
            pickerLabel?.text = "\(attachedVolumes[row].device!) \(attachedVolumes[row].volumeId!)"
            pickerLabel?.textColor = UIColor.white
        }
        
        return pickerLabel!;
        
    }
    
    // Capture the picker view selection
    /*func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        /*if pickerView == imagePickerView {
            self.imageId = images[row].id!
        } else if pickerView == flavorPickerView {
            self.flavorId = flavors[row].id!
        }*/
        
    }*/



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
