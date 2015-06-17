//
//  VideoDetailViewController.swift
//  Noders
//
//  Created by Jose Vildosola on 27-05-15.
//  Copyright (c) 2015 DevIn. All rights reserved.
//

import UIKit
import XCDYouTubeKit
import SDWebImage

class VideoDetailViewController: UIViewController {

    @IBOutlet weak var videoPreview: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDesc: UITextView!
    @IBOutlet weak var videoPlayButton: UIImageView!
    var selectedVideo:VideoModel?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.greenColor()
        let sel:Selector = "playVideo:"
        videoPreview.userInteractionEnabled = true
        videoPreview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: sel))
        videoPlayButton.userInteractionEnabled = true
        videoPlayButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: sel))
        self.videoTitle.text = self.selectedVideo?.title
        self.videoDesc.text = self.selectedVideo?.descripcion
        self.videoPreview.sd_setImageWithURL(NSURL(string: self.selectedVideo!.thumbnailUrlHigh))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playVideo(gestureRecognizer: UITapGestureRecognizer){
        let xcdYoutube:XCDYouTubeVideoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: selectedVideo!.videoId)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.presentMoviePlayerViewControllerAnimated(xcdYoutube)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
