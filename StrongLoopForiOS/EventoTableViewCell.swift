//
//  EventoTableViewCell.swift
//  Noders
//
//  Created by Jose Vildosola on 25-05-15.
//  Copyright (c) 2015 DevIn. All rights reserved.
//

import UIKit

class EventoTableViewCell: UITableViewCell {

    @IBOutlet weak var eventoImage: UIImageView!
    @IBOutlet weak var eventoTitle: UILabel!
    @IBOutlet weak var eventoDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
