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

func deleteServer(serverID: String) {
    getAuthToken { keystoneToken in
        // Create Request
        var req = URLRequest(url: URL(string: "http://\(controller):\(novaport)/v2.1/servers/\(serverID)")!)
        req.httpMethod = "GET"
        
        req.allHTTPHeaderFields = ["Content-Type": "application/json", "X-Auth-Token": "\(keystoneToken)"]
        
        //print("Headers: \(req.allHTTPHeaderFields)")
        
        let session = URLSession.shared
        
        // Perform Request
        session.dataTask(with: req) {result, res, err in
            guard result != nil else {
                print("No result")
                return
            }
            
            // Convert results to a JSON object
            //let json = JSON(data: result!)
            //print(json)
            
            }.resume()
    }
}

/*
func createServer(complete: @escaping ([Server]) -> ()) {
    getAuthToken { keystoneToken in

        let parameters = ["server": [
                "name": serverName,
                "imageRef": image,
                "flavorRef": flavor
            ]
        ]
        
        // Create Request
        var novaReq = URLRequest(url: URL(string: "http://\(controller):\(novaport)/v2.1/servers")!)
        novaReq.httpMethod = "GET"
        
        if JSONSerialization.isValidJSONObject(parameters) == false {
            print("Invalid JSON")
        }
        
        do {
            novaReq.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                      options: JSONSerialization.WritingOptions())
        } catch {
            print("Could not create JSON body")
        }
        
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
*/
func getFlavors() {
    getAuthToken { keystoneToken in
        // Create Request
        var novaReq = URLRequest(url: URL(string: "http://\(controller):\(novaport)/v2.1/flavors")!)
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
            print(json)
            /*
            var flavorList = [Flavor]()
            
            for (_, item) in json["flavors"] {
                let serverInfo = Server(name: item["name"].string!, id: item["id"].string!)
                serverList.append(serverInfo)
            }
            */
            //complete(flavorList)
            }.resume()
    }
}
