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
