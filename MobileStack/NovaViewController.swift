import UIKit
import Foundation

public let novaport = Config.NOVAPORT

func getServers(complete: @escaping ([Server]) -> ()) {
    getAuthToken { keystoneToken in
        // Create Request
        var novaReq = URLRequest(url: URL(string: "http://\(controller):\(novaport)/v2.1/servers")!)
        novaReq.httpMethod = "GET"
        
        novaReq.allHTTPHeaderFields = ["Content-Type": "application/json", "X-Auth-Token": "\(keystoneToken)"]
        
        let session = URLSession.shared
        
        // Perform Request
        session.dataTask(with: novaReq) {result, res, err in
            guard let result = result else {
                print("No result")
                return
            }
            
            // Convert results to a JSON object
            let json = JSON(data: result)
            
            var serverList = [Server]()
            
            for (_, item) in json["servers"] {
                let serverInfo = Server(name: item["name"].string!, id: item["id"].string!)
                serverList.append(serverInfo)
            }

            complete(serverList)
            }.resume()
    }
}
