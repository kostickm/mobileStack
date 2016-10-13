//
//  ManageVolumeViewController.swift
//  MobileStack
//
//  Created by Michael Brewer on 10/13/16.
//
//

import UIKit

class ManageVolumeViewController: UIViewController {
    var volumeName = ""
    var volumeId = ""
    var volumeStatus = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.volumeId)
        print(self.volumeName)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
