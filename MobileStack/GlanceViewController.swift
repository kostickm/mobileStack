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

public let glanceport = Config.GLANCEPORT

func getImages(complete: @escaping ([Image]) -> ()) {
    getAuthToken { keystoneToken in
    // Create Request
    var req = URLRequest(url: URL(string: "http://\(controller):\(glanceport)/v2/images")!)
    req.httpMethod = "GET"

    req.allHTTPHeaderFields = ["Content-Type": "application/json", "X-Auth-Token": "\(keystoneToken)"]

    //print("Headers: \(req.allHTTPHeaderFields)")

    let session = URLSession.shared

    // Perform Request
    session.dataTask(with: req) {result, res, err in
        guard let result = result else {
            print("No result")
            return
        }

        // Convert results to a JSON object
        let json = JSON(data: result)

        var imageList = [Image]()

        for (_, item) in json["images"] {
            let imageInfo = Image(name: item["name"].string!, id: item["id"].string!, createdAt: item["created_at"].string!)
            imageList.append(imageInfo)
        }

        //let imageData = [
        //    Image(name:"Tiny", os:"Ubuntu 14.04"),
        //    Image(name:"Medium", os:"Ubuntu 16.04"),
        //    Image(name:"Large", os:"RHEL 7") ]
        //globalImages = imageList
        //self.authTokenField.text = "\(json)"
        complete(imageList)
        }.resume()
    }
}

func deleteImage(imageID: String) {
    getAuthToken { keystoneToken in
        // Create Request
        var req = URLRequest(url: URL(string: "http://\(controller):\(glanceport)/v2/images/\(imageID)")!)
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
