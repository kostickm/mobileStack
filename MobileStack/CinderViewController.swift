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

public let cinderport = Config.CINDERPORT

func getVolumes(complete: @escaping ([Volume]) -> ()) {
    getAuthToken { keystoneToken in
        // Create Request
        var cinderReq = URLRequest(url: URL(string: "http://\(controller):\(cinderport)/v2/\(tenantId)/volumes/detail")!)
        cinderReq.httpMethod = "GET"

        cinderReq.allHTTPHeaderFields = ["Content-Type": "application/json", "X-Auth-Token": "\(keystoneToken)"]

        //print("Headers: \(cinderReq.allHTTPHeaderFields)")

        let session = URLSession.shared

        // Perform Request
        session.dataTask(with: cinderReq) {result, res, err in
            guard let result = result else {
                print("No result")
                return
            }

            // Convert results to a JSON object
            let json = JSON(data: result)

            var volumeList = [Volume]()

            for (_, item) in json["volumes"] {
                let volumeInfo = Volume(name: item["name"].string, id: item["id"].string, status: item["status"].string, size: String(describing: item["size"].object))
                volumeList.append(volumeInfo)
            }
            //self.authTokenField.text = "\(json)"
            complete(volumeList)
            }.resume()
    }
}

func availableVolumes(complete: @escaping ([Volume]) -> ()) {
    getAuthToken { keystoneToken in
        // Create Request
        var cinderReq = URLRequest(url: URL(string: "http://\(controller):\(cinderport)/v2/\(tenantId)/volumes/detail")!)
        cinderReq.httpMethod = "GET"

        cinderReq.allHTTPHeaderFields = ["Content-Type": "application/json", "X-Auth-Token": "\(keystoneToken)"]

        let session = URLSession.shared

        // Perform Request
        session.dataTask(with: cinderReq) {result, res, err in
            guard let result = result else {
                print("No result")
                return
            }

            // Convert results to a JSON object
            let json = JSON(data: result)

            var volumeList = [Volume]()

            for (_, item) in json["volumes"] {
                if item["status"].string! == "available" {
                    let volumeInfo = Volume(name: item["name"].string!, id: item["id"].string!, status: item["status"].string!, size: String(describing: item["size"].object))
                    volumeList.append(volumeInfo)
                }
            }
            complete(volumeList)
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

func deleteVolume(id: String) {
    getAuthToken { keystoneToken in


        // Create Request
        var cinderReq = URLRequest(url: URL(string: "http://\(controller):\(cinderport)/v2/\(tenantId)/volumes/\(id)")!)
        cinderReq.httpMethod = "DELETE"

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
            print(result)
            print(res)
            print(err)

            // Convert results to a JSON object
            //let json = JSON(data: result)

            }.resume()
    }
}
