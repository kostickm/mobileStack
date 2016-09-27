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
            //print("In button call:\(keystoneToken)")
        }
        //var imageList = globalImages
        print("HERE")
        //print(imageList)
        deleteImage()
        //getVolumes()
        //getServers()
        //getNetworks()
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

