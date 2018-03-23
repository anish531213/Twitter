//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Anish Adhikari on 3/22/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileIdLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var userTimelineTableView: UITableView!
    
    var tweets: [Tweet] = []
    var user: User = User.current!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTimelineTableView.delegate = self
        userTimelineTableView.dataSource = self
        
        userTimelineTableView.rowHeight = UITableViewAutomaticDimension
        userTimelineTableView.estimatedRowHeight = 250

        profileImageView.layer.cornerRadius = 10
        profileImageView.af_setImage(withURL: user.profileImageUrl)
        
        profileIdLabel.text = "@\(user.id)"
        profileNameLabel.text = user.name
        followersCountLabel.text = "\(user.follwersCount)"
        followingCountLabel.text = "\(user.friendsCount)"
        tweetCountLabel.text = "\(user.tweetCount)"
        // Do any additional setup after loading the view.
        
        //print(user.backgroundImageUrl)
        if user.backgroundImageUrl != nil {
            backgroundImageView.af_setImage(withURL: user.backgroundImageUrl)
        }
        
        retrieveTimelineTweets()
        
    }
    
    func retrieveTimelineTweets() {
        //print(user.name)
        APIManager.shared.getUserTimeline(with: user.id, options: [:]) { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.userTimelineTableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(tweets.count)
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
