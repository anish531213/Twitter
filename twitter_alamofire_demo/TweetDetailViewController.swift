//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Anish Adhikari on 3/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailViewController: UITableViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var tweetDescriptionLabel: UILabel!
    @IBOutlet weak var profileIDLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favroiteCountLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet var staticTableView: UITableView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        staticTableView.rowHeight = UITableViewAutomaticDimension
        staticTableView.estimatedRowHeight = 70
        
        profileImageView.layer.cornerRadius = 20
        
        tweetDescriptionLabel.text = tweet.text
        profileImageView.af_setImage(withURL: tweet.user.profileImageUrl)
        profileNameLabel.text = tweet.user.name
        profileIDLabel.text = "@\(tweet.user.id)"
        retweetCountLabel.text = "\(tweet.retweetCount)"
        favroiteCountLabel.text = "\(tweet.favoriteCount!)"
        createdAtLabel.text = tweet.createdAtStringLong

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let replyVC = segue.destination as! ComposeViewController
        replyVC.initialtext = "@\(tweet.user.id) "
        replyVC.tweetButton.title = "Reply"
    }

    
    @IBAction func retweetButtonTapped(_ sender: Any) {
    }
    
    @IBAction func faveroiteButtonTapped(_ sender: Any) {
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
