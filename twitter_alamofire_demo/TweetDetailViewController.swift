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
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var faveroiteButton: UIButton!
    
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
        //print("\(retweetButton.isHighlighted)")
        if tweet.favorited! == true {
            faveroiteButton.isSelected = true
            faveroiteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        
        if tweet.retweeted! == true {
            retweetButton.isSelected = true
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        
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
        if segue.identifier == "replySegue" {
            let replyVC = segue.destination as! ComposeViewController
            replyVC.initialtext = "@\(tweet.user.id) "
            replyVC.tweetButton.title = "Reply"
        }
        else if segue.identifier == "profileSegue" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.user = tweet.user
        }
       
    }

    
    @IBAction func retweetButtonTapped(_ sender: Any) {
        if retweetButton.isSelected == true {
            retweetButton.isSelected = false
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            unRetweetTweet()
        }else {
            retweetButton.isSelected = true
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            retweetTweet()
        }
    }
    
    @IBAction func faveroiteButtonTapped(_ sender: Any) {
        if faveroiteButton.isSelected == true {
            faveroiteButton.isSelected = false
            faveroiteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            unFavoriteTweet()
        }else {
            faveroiteButton.isSelected = true
            faveroiteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            favoriteTweet()
        }
        
    }
    
    func retweetTweet() {
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                self.tweet.retweetCount += 1
                self.tweet.retweeted = true
                self.refreshData()
            }
        }
    }
    
    func unRetweetTweet() {
        APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error un-retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully un-retweeted the following Tweet: \n\(tweet.text)")
                self.tweet.retweetCount -= 1
                self.tweet.retweeted = false
                self.refreshData()
            }
        }
    }
    
    func favoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favoriting the following Tweet: \n\(tweet.text)")
                self.tweet.favoriteCount! += 1
                self.tweet.favorited = true
                self.refreshData()
            }
        }
    }
    
    func unFavoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error un-favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully un-favoriting the following Tweet: \n\(tweet.text)")
                self.tweet.favoriteCount! -= 1
                self.tweet.favorited = false
                self.refreshData()
            }
        }
    }
    
    func refreshData() {
        retweetCountLabel.text = "\(tweet.retweetCount)"
        favroiteCountLabel.text = "\(tweet.favoriteCount!)"
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
