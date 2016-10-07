//
//  serverTableViewController.swift
//  MobileStack
//
//  Created by Megan Dawn Kostick on 9/21/16.
//
//

import UIKit

class ServerTableViewController: UITableViewController {
    
    var servers = [Server]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        getServers { servers in
            self.servers = servers
            self.tableView.reloadData()
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
            })
        }
        self.refreshControl?.addTarget(self, action: #selector(ServerTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        getServers { servers in
            self.servers = servers
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
            })
        }
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.servers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ServerTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ServerTableViewCell
        
        let server = self.servers[indexPath.row] as Server
        cell.backgroundColor = UIColor.darkGray
        cell.serverNameLabel.text = server.name
        cell.serverNameLabel.textColor = UIColor.white
        cell.serverIdLabel.text = server.id
        cell.serverIdLabel.textColor = UIColor.white
        switch server.status! {
            case "ACTIVE":
                cell.serverStatusImage.image = #imageLiteral(resourceName: "GreenCheckmark")
            case "SHUTOFF":
                cell.serverStatusImage.image = #imageLiteral(resourceName: "RedCircle")
        default:
            cell.serverStatusImage.image = #imageLiteral(resourceName: "GreenCheckmark")
        }
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            deleteServer(serverID: servers[indexPath.row].id!)
            servers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == "ManageServer" {
            if let destinationVC = segue.destination as? ManageServerViewController,
               let indexPath = self.tableView.indexPathForSelectedRow {
                destinationVC.serverName = servers[indexPath.row].name!
                destinationVC.serverId = servers[indexPath.row].id!
                destinationVC.serverStatus = servers[indexPath.row].status!
            }
        }
     }
    
    
    
    @IBAction func unwindToServerList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ServerViewController, let server = sourceViewController.server {
            
            // Add a new server
            let newIndexPath = IndexPath(row: servers.count, section: 0)
            
            servers.append(server)
            
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            
        }
        
    }

}
