//
//  VideosViewController.swift
//  Noders
//
//  Created by Jose Vildosola on 18-05-15.
//  Copyright (c) 2015 DevIn. All rights reserved.
//

import UIKit
import SDWebImage
import XCDYouTubeKit
import MBProgressHUD
import SpinKit

class VideosViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, VideoManagerDelegate{

    
    @IBOutlet weak var videosTableView: UITableView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var videosArray:NSArray = []
    var videoSelected:VideoModel?
    var hud: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        videosTableView.registerClass(VideoTableViewCell.self, forCellReuseIdentifier: "videoCell")
        videosTableView.registerNib(UINib(nibName: "VideoCellView", bundle: nil), forCellReuseIdentifier: "videoCell")
        let videoManager:VideoManager = VideoManager()
        videoManager.delegate = self
        videosTableView.delegate = self
        videosTableView.dataSource = self
        let spinner:RTSpinKitView = RTSpinKitView(style: RTSpinKitViewStyle.Style9CubeGrid)
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud!.labelText = "Cargando"
        hud!.mode = MBProgressHUDMode.CustomView
        hud!.customView = spinner
        videoManager.getVideosByChannel("UC7tUsO3S7424TMcgSCUOCow")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:VideoTableViewCell = tableView.dequeueReusableCellWithIdentifier("videoCell") as! VideoTableViewCell
        let video:VideoModel = videosArray.objectAtIndex(indexPath.row) as! VideoModel
        cell.nombreVideo.text = video.title
        cell.thumbnailVideo.sd_setImageWithURL(NSURL(string: video.thumbnailUrlHigh))
        cell.duracionVideo.text = video.duration
        let shadowPath = UIBezierPath(rect: cell.cellView.bounds)
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowColor = UIColor.blackColor().CGColor
        cell.cellView.layer.shadowOffset = CGSizeMake(0.0, 0.5)
        cell.cellView.layer.shadowOpacity = 0.5
        cell.cellView.layer.shadowPath = shadowPath.CGPath
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArray.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.videoSelected = self.videosArray.objectAtIndex(indexPath.row) as? VideoModel
            self.performSegueWithIdentifier("videoDetailSegue", sender: nil)
        })
    }
    
    func loadVideos(channelid: String) -> NSArray{
        var videosTmp:NSArray = [];
        return videosTmp;
    }
    
    func videoListDownloaded(videos: NSArray) {
        self.videosArray = videos
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.videosTableView.reloadData()
        })
    }
    
    func didFailToDownload(error: NSError) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.hud!.hide(true)
            let alert:SCLAlertViewResponder = SCLAlertView().showError("Videos", subTitle: "Hubo un error al recuperar la lista de videos", closeButtonTitle: "Aceptar", duration: 0.0)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let videoDetailVC = segue.destinationViewController as! VideoDetailViewController
        videoDetailVC.selectedVideo = videoSelected
    }
    

}
