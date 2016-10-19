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
import Foundation

public let novaport = Config.NOVAPORT
public let tenantId = Config.TENANTID

func getServers(complete: @escaping ([Server]) -> ()) {
    getAuthToken { keystoneToken in
        // Create Request
        var novaReq = URLRequest(url: URL(string: "http://\(controller):\(novaport)/v2.1/servers/detail")!)
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
                let serverInfo = Server(name: item["name"].string!, id: item["id"].string!, status: item["status"].string!)
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
        req.httpMethod = "DELETE"

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

func createServer(name: String, imageId: String, flavorId: String) {
    getAuthToken { keystoneToken in

        let parameters:[String: Any] = ["server": [
                "name": name,
                "imageRef": imageId,
                "flavorRef": flavorId,
                "networks": [["uuid": "0a4ef5ac-0638-451b-8dbb-ae5bda7ae5ba"]]
            ]
        ]

        // Create Request
        var novaReq = URLRequest(url: URL(string: "http://\(controller):\(novaport)/v2.1/servers")!)
        novaReq.httpMethod = "POST"

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
            guard result != nil else {
                print("No result")
                return
            }

            // Convert results to a JSON object
            //let json = JSON(data: result)

            }.resume()
    }
}

func getFlavors(complete: @escaping ([Flavor]) -> ()) {
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

            var flavorList = [Flavor]()

            for (_, item) in json["flavors"] {
                let serverInfo = Flavor(name: item["name"].string!, id: item["id"].string!)
                flavorList.append(serverInfo)
            }

            complete(flavorList)
            }.resume()
    }
}

func rebootServer(serverId: String) {
    getAuthToken { keystoneToken in

        let parameters:[String: Any] = ["reboot": [
            "type": "HARD"
            ]
        ]

        // Create Request
        var novaReq = URLRequest(url: URL(string: "http://\(controller):\(novaport)/v2.1/\(tenantId)/servers/\(serverId)/action")!)
        novaReq.httpMethod = "POST"

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
            guard result != nil else {
                print("No result")
                return
            }

            // Convert results to a JSON object
            //let json = JSON(data: result)

            }.resume()
    }
}

func startServer(serverId: String) {
    getAuthToken { keystoneToken in

        let parameters:[String: Any] = [ "os-start": "null" ]

        // Create Request
        var novaReq = URLRequest(url: URL(string: "http://\(controller):\(novaport)/v2.1/\(tenantId)/servers/\(serverId)/action")!)
        novaReq.httpMethod = "POST"

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
            guard result != nil else {
                print("No result")
                return
            }

            // Convert results to a JSON object
            //let json = JSON(data: result)

            }.resume()
    }
}

func stopServer(serverId: String) {
    getAuthToken { keystoneToken in

        let parameters:[String: Any] = [ "os-stop": "null" ]

        // Create Request
        var novaReq = URLRequest(url: URL(string: "http://\(controller):\(novaport)/v2.1/\(tenantId)/servers/\(serverId)/action")!)
        novaReq.httpMethod = "POST"

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
            guard result != nil else {
                print("No result")
                return
            }

            // Convert results to a JSON object
            //let json = JSON(data: result)

            }.resume()
    }
}

func attachVolumeToServer(serverId: String, volumeId: String) {
    getAuthToken { keystoneToken in
        
        let parameters:[String: Any] = ["volumeAttachment": [
            "volumeId": volumeId,
            ]
        ]
        
        // Create Request
        var novaReq = URLRequest(url: URL(string: "http://\(controller):\(novaport)/v2.1/\(tenantId)/servers/\(serverId)/os-volume_attachments")!)
        novaReq.httpMethod = "POST"
        
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
            guard result != nil else {
                print("No result")
                return
            }
            
            // Convert results to a JSON object
            //let json = JSON(data: result)
            
            }.resume()
    }
}
