import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authTokenField: UITextField!
    
    
    @IBAction func getAuthToken(_ sender: AnyObject) {
        // Define Request Body Parameters
        let parameters = [
            "auth": [
                "tenantName": "admin",
                "passwordCredentials": [
                    "username": "admin",
                    "password": "<password>"
                ]
            ]
        ]
        
        // Create Request
        var req = URLRequest(url: URL(string: "http://<ipAddress>:<port>/v2.0/tokens")!)
        req.httpMethod = "POST"
        
        do {
            req.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                      options: JSONSerialization.WritingOptions())
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
            let json = JSON(data: result)
            
            print(json)
            self.authTokenField.text = "\(json)"
            
            }.resume()
    }
    
    @IBAction func reset(_ sender: AnyObject) {
        authTokenField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

