//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation
import DateToolsSwift

class Tweet {
    
    // MARK: Properties
    var id: Int64 // For favoriting, retweeting & replying
    var text: String // Text content of tweet
    var favoriteCount: Int? // Update favorite count label
    var favorited: Bool? // Configure favorite button
    var retweetCount: Int // Update favorite count label
    var retweeted: Bool? // Configure retweet button
    //var replyCount: Int? // Reply count of tweet
    var user: User // Contains name, screenname, etc. of tweet author
    var createdAtString: String // Display date
    var createdAtStringLong: String // Display long date
    
    // MARK: - Create initializer with dictionary
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as! Int64
        text = dictionary["text"] as! String
        favoriteCount = dictionary["favorite_count"] as? Int
        //replyCount = dictionary["reply_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as! Int
        retweeted = dictionary["retweeted"] as? Bool
        //print(favorited!)
        
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        let createdAtOriginalString = dictionary["created_at"] as! String
//        let formatter = DateFormatter()
//        // Configure the input format to parse the date string
//        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
//        // Convert String to Date
//        let date = formatter.date(from: createdAtOriginalString)!
//        // Configure output format
//        formatter.dateStyle = .short
//        formatter.timeStyle = .none
//        // Convert Date to String
//        createdAtString = formatter.string(from: date)
        let date = Date(dateString: createdAtOriginalString, format: "E MMM d HH:mm:ss Z y")
        
        createdAtString = "\(date.shortTimeAgoSinceNow)"
        
        createdAtStringLong = "\(date.timeAgoSinceNow)"
    }
    
    static func tweets(with array: [[String: Any]]) -> [Tweet] {
        return array.flatMap({ (dictionary) -> Tweet in
            Tweet(dictionary: dictionary)
        })
    }
    
}

