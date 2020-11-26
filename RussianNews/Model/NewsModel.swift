//
//  NewsModel.swift
//  RussianNews
//
//  Created by Яблочко on 18.11.2020.
//  Copyright © 2020 Roman Avdonin. All rights reserved.
//

import Foundation

struct Article {
    
    var headLine: String?
    var imageUrl: String?
    var publishedAt: String?
    var desc: String?
    var content: String?
    
    init?(dictionary: [String : AnyObject]) {
        
        headLine = dictionary["title"] as? String
        imageUrl = dictionary["urlToImage"] as? String
        publishedAt = dictionary["publishedAt"] as? String
        desc = dictionary["description"] as? String
        content = dictionary["content"] as? String 
    }
}

