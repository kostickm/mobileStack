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

public let user = Config.USERNAME
public let password = Config.PASSWORD
public let controller = Config.CONTROLLERIP
public let port = Config.PORT

func getAuthToken(completion: @escaping (String) -> ()) {
    // Define Request Body Parameters
    let parameters: [String: Any] = [
        "auth": [
            "tenantName": "admin",
            "passwordCredentials": [
                "username": user,
                "password": password
            ]
        ]
    ]

    // Create Request
    var req = URLRequest(url: URL(string: "http://\(controller):\(port)/v2.0/tokens")!)
    req.httpMethod = "POST"
    req.allHTTPHeaderFields = ["Content-Type": "application/json"]

    do {
        req.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
    } catch {
        print("Something went wrong.")
    }

    let session = URLSession.shared

    // Perform Request
    session.dataTask(with: req) {result, res, err in
        guard let result = result else {
            print("No result")
            return
        }

        // Convert results to a JSON object
        var json = JSON(data: result)

        let keystoneToken = json["access"]["token"]["id"].object as! String
        //let serviceName = json["access"]["serviceCatalog"]["name"].object

        //self.authTokenField.text = "\(json)"
        completion(keystoneToken)
        }.resume()
}

class AuthViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authTokenField: UITextField!

    @IBAction func getAuthTokenButton(_ sender: AnyObject) {
        getAuthToken { keystoneToken in

            DispatchQueue.main.async(execute: { () -> Void in
                self.authTokenField.text = keystoneToken
            })
        }

        getFlavors { flavor in

        }
        //var imageList = globalImages
        //print(imageList)
        //deleteImage()
        getVolumes { volumes in
        }
        /*getServers { servers in
            print(servers)
        }*/
        //createVolume(name: "Test1", size: "1")
        //availableVolumes { volumes in
        //}
        //deleteVolume(id: "2c36c622-b67c-410a-8a1f-bb7190aa85c3")
        //getNetworks()
    }

    @IBAction func reset(_ sender: AnyObject) {
        self.authTokenField.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        /*getAuthToken { keystoneToken in

            DispatchQueue.main.async(execute: { () -> Void in
                self.authTokenField.text = keystoneToken
            })
        }*/

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
