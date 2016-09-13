//
//  GlanceViewController.swift
//  MobileStack
//
//  Created by Michael Brewer on 9/13/16.
//
//
import UIKit
import Foundation

public let glanceport = Config.GLANCEPORT

func getImages() {
    getAuthToken { keystoneToken in
    // Create Request
    var req = URLRequest(url: URL(string: "http://\(controller):\(glanceport)/v2/images")!)
    req.httpMethod = "GET"
    
    req.allHTTPHeaderFields = ["Content-Type": "application/json", "X-Auth-Token": "\(keystoneToken)"]
    
    print("Headers: \(req.allHTTPHeaderFields)")
    
    let session = URLSession.shared
    
    // Perform Request
    session.dataTask(with: req) {result, res, err in
        guard let result = result else {
            print("No result")
            return
        }
        
        // Convert results to a JSON object
        let json = JSON(data: result)
        
        print("\(json)")
        //self.authTokenField.text = "\(json)"
        }.resume()
    }
}
