//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import TTTAttributedLabel

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postedtimeLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileIdLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetcountLabel: UILabel!
    @IBOutlet weak var faveroiteCountLabel: UILabel!
    @IBOutlet weak var faveroiteButtonView: UIImageView!
    @IBOutlet weak var retweetButtonView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            //tweetTextLabel.
            tweetTextLabel.text = tweet.text
            postedtimeLabel.text = "· \(tweet.createdAtString)"
            profileNameLabel.text = tweet.user.name
            profileIdLabel.text = "@\(tweet.user.id)"
            profileImageView.af_setImage(withURL: tweet.user.profileImageUrl)
            retweetcountLabel.text = "\(tweet.retweetCount)"
            faveroiteCountLabel.text = "\(tweet.favoriteCount!)"
            //replyCountLabel.text = "\(tweet.replyCount)"
            if (tweet.favorited!) {
                faveroiteButtonView.isHighlighted = true
            }
            if (tweet.retweeted!) {
                retweetButtonView.isHighlighted = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 32.5;
        
        let retweetClickGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapRetweetButton(_:)))
        retweetButtonView.addGestureRecognizer(retweetClickGesture)
        // Initialization code
        
        let faveroiteClickGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapFaveroiteButton(_:)))
        faveroiteButtonView.addGestureRecognizer(faveroiteClickGesture)
        
        //retweetButtonView.isHighlighted = tweet.retweeted! as Bool
        
    }
    
    func didTapRetweetButton(_ sender: UITapGestureRecognizer) {
        //print(retweetButtonView.isHighlighted)
        if (tweet.retweeted!) {
            retweetButtonView.isHighlighted = false
            //print (tweet.retweeted!)
            tweet.retweeted = false
            tweet.retweetCount -= 1
            unRetweetTweet()
        } else {
            retweetButtonView.isHighlighted = true
            tweet.retweeted = true
            tweet.retweetCount += 1
            retweetTweet()
        }
        
        print("Retweet Button Tapped")
        refreshData()
    }
    
    func didTapFaveroiteButton(_ sender: UITapGestureRecognizer) {
        //print(tweet.favorited!)
        //print(retweetButtonView.isHighlighted)
        if (tweet.favorited!) {
            faveroiteButtonView.isHighlighted = false
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            unFavoriteTweet()
        } else {
            faveroiteButtonView.isHighlighted = true
            tweet.favorited = true
            tweet.favoriteCount! += 1
            favoriteTweet()
        }
        
        
        print("Faveriote Button Tapped")
        refreshData()
    }
    
    func retweetTweet() {
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweeted the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    func unRetweetTweet() {
        APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error un-retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully un-retweeted the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    func favoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favoriting the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    func unFavoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error un-favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully un-favoriting the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    
    
    
    func refreshData() {
        retweetcountLabel.text = "\(tweet.retweetCount)"
        faveroiteCountLabel.text = "\(tweet.favoriteCount!)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
