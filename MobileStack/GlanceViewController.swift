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
        
        print(json)
        print("LIST BELOW")
        print(imageList)
        //globalImages = imageList
        //self.authTokenField.text = "\(json)"
        complete(imageList)
        }.resume()
    }
}
//imageID: String

func deleteImage() {
    getAuthToken { keystoneToken in
        // Create Request
        var req = URLRequest(url: URL(string: "http://\(controller):\(glanceport)/v2/images/")!)
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
            
            //print(json["images"][0])
            //self.authTokenField.text = "\(json)"
            }.resume()
    }
}
