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

class ServerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var server: Server?
    var images = [Image]()
    var flavors = [Flavor]()
    var volumes = [Volume]()
    var imageId:String = ""
    var flavorId:String = ""
    var volumeId:String = ""

    @IBOutlet weak var saveServerButton: UIBarButtonItem!
    @IBAction func cancelServerButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var serverNameLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var flavorLabel: UILabel!

    @IBOutlet weak var serverNameTextField: UITextField!
    @IBOutlet weak var flavorPickerView: UIPickerView!
    @IBOutlet weak var imagePickerView: UIPickerView!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon

        // Connect data:
        //self.imagePickerView.delegate = self
        //self.imagePickerView.dataSource = self
        //self.flavorPickerView.delegate = self
        //self.flavorPickerView.dataSource = self

        getImages { images in
            self.images = images
            DispatchQueue.main.async(execute: { () -> Void in
                self.imageId = images[0].id!
                self.imagePickerView.delegate = self
                self.imagePickerView.dataSource = self
            })
        }

        getFlavors { flavors in
            self.flavors = flavors
            DispatchQueue.main.async(execute: { () -> Void in
                self.flavorId = flavors[0].id!
                self.flavorPickerView.delegate = self
                self.flavorPickerView.dataSource = self
            })
        }
        
        // Handle the text field’s user input through delegate callbacks.
        //serverNameTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid Volume name.
        //checkValidServerName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveServerButton.isEnabled = false
    }
    
    func checkValidServerName() {
        // Disable the Save button if the text field is empty.
        let text = serverNameTextField.text ?? ""
        saveServerButton.isEnabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidServerName()
        navigationItem.title = textField.text
    }

    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }

    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {

        var count = 0
        if pickerView == imagePickerView {
            count = images.count
        } else if pickerView == flavorPickerView {
            return flavors.count
        }

        return count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var pickerLabel = view as? UILabel;

        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()

            pickerLabel?.font = UIFont(name: "Helvetica", size: 10)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }

        if pickerView == imagePickerView {
            pickerLabel?.text = images[row].name
            pickerLabel?.textColor = UIColor.white
        } else if pickerView == flavorPickerView {
            pickerLabel?.text = flavors[row].name
            pickerLabel?.textColor = UIColor.white
        }

        return pickerLabel!;

    }

    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if pickerView == imagePickerView {
            self.imageId = images[row].id!
        } else if pickerView == flavorPickerView {
            self.flavorId = flavors[row].id!
        }

    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveServerButton === sender as AnyObject? {
            let name = serverNameTextField.text ?? ""

            // Set the server to be passed to ServerTableViewController after the unwind segue.
            createServer(name: name, imageId: imageId, flavorId: flavorId)
        }
    }
}
