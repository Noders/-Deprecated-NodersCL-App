//
//  VideoManager.swift
//  Noders
//
//  Created by Jose Vildosola on 21-05-15.
//  Copyright (c) 2015 DevIn. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol VideoManagerDelegate{
    func videoListDownloaded(videos: NSArray);
    func didFailToDownload(error: NSError);
}

class VideoManager: NSObject {
    var delegate: VideoManagerDelegate?
    func getVideosByChannel(channel: String){
        var videoArray:NSMutableArray = []
        let httpClient = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: NSURL(string: "https://www.googleapis.com/youtube/v3/search?key=AIzaSyBo23LhSupwDkusUkKPcq0HOUvwxMgTNb8&channelId=\(channel)&part=snippet,id&order=date")!)
        let videoTask = httpClient.dataTaskWithRequest(request, completionHandler: { (videoData, response, error) -> Void in
            if let videoErr = error {
                NSLog("Error: %s", videoErr)
            } else {
                var errorJson:NSError?
                let newJson = JSON(data: videoData, options: NSJSONReadingOptions.AllowFragments, error: &errorJson)

                let videosIdArray:NSMutableArray = NSMutableArray()
                for(index: String, item: JSON) in newJson["items"]{
                    let videoId = item["id"]["videoId"].stringValue
                    videosIdArray.addObject(videoId)
                }
                let videosIds = videosIdArray.componentsJoinedByString(",")
                let detailRequest = NSURLRequest(URL: NSURL(string: "https://www.googleapis.com/youtube/v3/videos?part=id,snippet,contentDetails&id=\(videosIds)&key=AIzaSyBo23LhSupwDkusUkKPcq0HOUvwxMgTNb8")!)
                let detailTask = httpClient.dataTaskWithRequest(detailRequest, completionHandler: { (detailData, detailResponse, detailError) -> Void in
                    if let detailErr = detailError {
                        print("Error: \(detailErr)")
                    } else {
                        var detailJsonError:NSError?
                        let detailJson = JSON(data: detailData, options: NSJSONReadingOptions.AllowFragments, error: &detailJsonError)
                        for(index: String, detailItem: JSON) in detailJson["items"]{
                            let videoId = detailItem["id"].stringValue
                            let snippet = detailItem["snippet"]
                            let title = snippet["title"].stringValue
                            let desc = snippet["description"].stringValue
                            let thumbnail = snippet["thumbnails"]
                            let thumbnailDefault = thumbnail["default"]["url"].stringValue
                            let thumbnailMedium = thumbnail["medium"]["url"].stringValue
                            let thumbnailHigh = thumbnail["high"]["url"].stringValue
                            let videoDuration = detailItem["contentDetails"]["duration"].stringValue
                            let video = VideoModel()
                            video.videoId = videoId
                            video.title = title
                            video.descripcion = desc
                            video.thumbnailUrlDefault = thumbnailDefault
                            video.thumbnailUrlMedium = thumbnailMedium
                            video.thumbnailUrlHigh = thumbnailHigh
                            video.duration = ConversionUtility.parseISO8601Time(videoDuration) as String
                            videoArray.addObject(video)
                        }
                        self.delegate?.videoListDownloaded(videoArray)
                    }
                })
                detailTask.resume()
            }
        })
        videoTask.resume()
    }
}
