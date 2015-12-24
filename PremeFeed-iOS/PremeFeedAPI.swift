//
//  PremeFeedAPI.swift
//  PremeFeed-iOS
//
//  Created by Cryptoc1 on 12/20/15.
//  Copyright © 2015 Cryptoc1. All rights reserved.
//

import Foundation


class PremeFeedAPI {
    // Default api url (NOTE: no ending slash)
    let apiURL: String = "https://premefeed.herokuapp.com/api/v1"
    
    init() {
        // Empty
    }

    /*
     *  
     *  The folloiwing functions make requests to the api endpoint on the heroku app, they're pretty straightfoward.
     *  Because NSURLSession is asynchronous, we have to use callbacks
     *
     */
    
    func getItemById(id: String, callback: (SupremeItem) -> Void) {
        self.makeRequest(NSURL(string: "\(self.apiURL)/item/id?id=\(id)")!, callback: { (json) -> Void in
            callback(SupremeItem(json: json))
            return
        })
    }
    
    func getItemByLink(link: String, callback: (SupremeItem) -> Void) {
        self.makeRequest(NSURL(string: "\(self.apiURL)/item/link?link=\(link.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!)")!, callback: { (json) -> Void in
            callback(SupremeItem(json: json))
            return
        })
    }
    
    func getItemsByTitle(title: String, callback: (Array<SupremeItem>) -> Void) {
        self.makeRequest(NSURL(string: "\(self.apiURL)/items/title?title=\(title.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!)")!, callback: { (json) -> Void in
            var ret = [SupremeItem]()
            for (i, _) in json.enumerate() {
                ret.append(SupremeItem(json: json[i]))
            }
            callback(ret)
            return
        })
    }
    
    func getItemsByAvailability(availability: String, callback: (Array<SupremeItem>) -> Void) {
        self.makeRequest(NSURL(string: "\(self.apiURL)/items/availability?availability=\(availability.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()))")!, callback: { (json) -> Void in
            var ret = [SupremeItem]()
            for (i, _) in json.enumerate() {
                ret.append(SupremeItem(json: json[i]))
            }
            callback(ret)
            return
        })
    }
    
    func getAllItems(callback: (Array<SupremeItem>) -> Void) {
        self.makeRequest(NSURL(string: "\(self.apiURL)/items/all")!, callback: { (json) -> Void in
            var ret = [SupremeItem]()
            for (i, _) in json.enumerate() {
                ret.append(SupremeItem(json: json[i]))
            }
             callback(ret)
        })
    }
    
    private func makeRequest(url: NSURL, callback: (JSON) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            callback(JSON(data: data!));
        }
        task.resume()
    }
}


// Converts JSON to a native object
class SupremeItem {
    var id: String?
    var title: String?
    var style: String?
    var link: String?
    var description: String?
    var price: Int?
    var images: Array<String>?
    var image: String?
    var availability: String?
    var results: Bool
    
    init(json: JSON) {
        if (json.stringValue == "No Results") {
            self.results = false
        } else {
            self.results = true
            self.id = json["id"].stringValue
            self.title = json["title"].stringValue
            self.style = json["style"].stringValue
            self.link = json["link"].stringValue
            self.description = json["description"].stringValue
            self.price = json["price"].intValue
            self.images = [String]()
            for (i, _) in json["images"].enumerate() {
                self.images!.append(json["images"][i].stringValue)
            }
            self.image = json["image"].stringValue
            self.availability = json["availability"].stringValue
        }
    }
}