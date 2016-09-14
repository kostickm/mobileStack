import UIKit
import Foundation

public let neutronport = Config.NEUTRONPORT

func getNetworks() {
    getAuthToken { keystoneToken in
        // Create Request
        var neutronReq = URLRequest(url: URL(string: "http://\(controller):\(neutronport)/v2.0/networks")!)
        neutronReq.httpMethod = "GET"
        
        neutronReq.allHTTPHeaderFields = ["Content-Type": "application/json", "X-Auth-Token": "\(keystoneToken)"]
        
        print("Headers: \(neutronReq.allHTTPHeaderFields)")
        
        let session = URLSession.shared
        
        // Perform Request
        session.dataTask(with: neutronReq) {result, res, err in
            guard let result = result else {
                print("No result")
                return
            }
            
            // Convert results to a JSON object
            let json = JSON(data: result)
            
            print("NETWORKS: \(json)")
            //self.authTokenField.text = "\(json)"
            }.resume()
    }
}
