//
//  VideoTableViewCell.swift
//  Noders
//
//  Created by Jose Vildosola on 18-05-15.
//  Copyright (c) 2015 DevIn. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreVideo: UILabel!
    
    @IBOutlet weak var thumbnailVideo: UIImageView!
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var duracionVideo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func infoVideoTapped(sender: AnyObject) {
    }
}
