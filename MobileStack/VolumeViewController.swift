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

class VolumeViewController: UIViewController, UITextFieldDelegate {

    var volumes = [Volume]()
    var volumeId:String = ""
    var volume: Volume?
    
    
    @IBOutlet weak var volumeNameLabel: UILabel!
    @IBOutlet weak var volumeSizeLabel: UILabel!
    @IBOutlet weak var volumeNameTextField: UITextField!
    @IBOutlet weak var volumeSizeTextField: UITextField!
    @IBOutlet weak var saveVolumeButton: UIBarButtonItem!

    @IBAction func cancelVolumeButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    /*override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }*/

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon

        getVolumes { volumes in

        }
        
        // Handle the text field’s user input through delegate callbacks.
        volumeNameTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid Volume name.
        checkValidVolumeName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveVolumeButton.isEnabled = false
    }
    
    func checkValidVolumeName() {
        // Disable the Save button if the text field is empty.
        let text = volumeNameTextField.text ?? ""
        saveVolumeButton.isEnabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidVolumeName()
        navigationItem.title = textField.text
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if saveVolumeButton === sender as AnyObject? {
            let name = volumeNameTextField.text ?? ""
            let size = volumeSizeTextField.text ?? "0"
            
            // Set the volume to be passed to VolumeTableViewController after the unwind segue.
            createVolume(name: name, size: size)
        }
    }
    

}
