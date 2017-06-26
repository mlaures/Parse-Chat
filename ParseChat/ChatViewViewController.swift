//
//  ChatViewViewController.swift
//  ParseChat
//
//  Created by Michael Hamlett on 6/26/17.
//  Copyright © 2017 Michael Hamlett. All rights reserved.
//

import UIKit
import Parse

class ChatViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatMessageField: UITextField!
    
    @IBOutlet weak var chatTable: UITableView!
    
    var tablePosts : [PFObject] = []
    
    @IBAction func sendButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message_fbu2017")
        chatMessage["user"] = PFUser.current()
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
            if success{
                print("Message was saved")
                self.chatMessageField.text = nil
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTable.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell

        if !tablePosts.isEmpty {
            
            let object = tablePosts[indexPath.row]
            
            let text = object["text"] as! String
            cell.textBox.text = text
            
            if let user = object["user"] as? PFUser {
                cell.userName.text = user.username
            } else {
                cell.userName.text = "someEmoji"
            }
        
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tablePosts.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTable.delegate = self
        chatTable.dataSource = self
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        chatTable.rowHeight = UITableViewAutomaticDimension
        chatTable.estimatedRowHeight = 50

        // Do any additional setup after loading the view.
    }
    
    func onTimer() {
        var query = PFQuery(className: "Message_fbu2017")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.tablePosts = posts
            }
        }
        
        chatTable.reloadData()
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
