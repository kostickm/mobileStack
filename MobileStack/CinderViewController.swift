import UIKit
import Foundation

public let cinderport = Config.CINDERPORT

func getVolumes() {
    getAuthToken { keystoneToken in
        // Create Request
        var cinderReq = URLRequest(url: URL(string: "http://\(controller):\(cinderport)/v2/\(tenantId)/volumes")!)
        cinderReq.httpMethod = "GET"
        
        cinderReq.allHTTPHeaderFields = ["Content-Type": "application/json", "X-Auth-Token": "\(keystoneToken)"]
        
        print("Headers: \(cinderReq.allHTTPHeaderFields)")
        
        let session = URLSession.shared
        
        // Perform Request
        session.dataTask(with: cinderReq) {result, res, err in
            guard let result = result else {
                print("No result")
                return
            }
            
            // Convert results to a JSON object
            let json = JSON(data: result)
            
            print("VOLUMES: \(json)")
            //self.authTokenField.text = "\(json)"
            }.resume()
    }
}

func availableVolumes() {
    getAuthToken { keystoneToken in
        // Create Request
        var cinderReq = URLRequest(url: URL(string: "http://\(controller):\(cinderport)/v2/\(tenantId)/volumes/detail")!)
        cinderReq.httpMethod = "GET"
        
        cinderReq.allHTTPHeaderFields = ["Content-Type": "application/json", "X-Auth-Token": "\(keystoneToken)"]
        
        print("Headers: \(cinderReq.allHTTPHeaderFields)")
        
        let session = URLSession.shared
        
        // Perform Request
        session.dataTask(with: cinderReq) {result, res, err in
            guard let result = result else {
                print("No result")
                return
            }
            
            // Convert results to a JSON object
            let json = JSON(data: result)
            
            for (i, _) in json["volumes"].enumerated() {
                print("\n\n")
                print(json["volumes"][i]["name"].object)
                print(json["volumes"][i]["id"].object)
                print(json["volumes"][i]["status"].object)
            }
            
            //("VOLUMES: \(json)")
            //self.authTokenField.text = "\(json)"
            }.resume()
    }
}

func createVolume(name: String, size: String) {
    getAuthToken { keystoneToken in
        
        let parameters:[String: Any] = ["volume": [
            "display_name": name,
            "size": size,
            "description": "Created via mobileStack app",
            ]
        ]
 
        // Create Request
        var cinderReq = URLRequest(url: URL(string: "http://\(controller):\(cinderport)/v2/\(tenantId)/volumes")!)
        cinderReq.httpMethod = "POST"
        
        if JSONSerialization.isValidJSONObject(parameters) == false {
            print("Invalid JSON")
        }
        
        do {
            cinderReq.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                          options: JSONSerialization.WritingOptions())
        } catch {
            print("Could not create JSON body")
        }
        
        cinderReq.allHTTPHeaderFields = ["Content-Type": "application/json", "X-Auth-Token": "\(keystoneToken)"]
        
        let session = URLSession.shared
        
        print("Headers: \(cinderReq.allHTTPHeaderFields)")
        print("Body: \(cinderReq.httpBody)")
        
        // Perform Request
        session.dataTask(with: cinderReq) {result, res, err in
            guard result != nil else {
                print("No result")
                return
            }
            
            // Convert results to a JSON object
            //let json = JSON(data: result)
            
            }.resume()
    }
}
