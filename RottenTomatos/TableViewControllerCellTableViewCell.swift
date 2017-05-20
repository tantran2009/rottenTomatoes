//
//  TableViewControllerCellTableViewCell.swift
//  RottenTomatos
//
//  Created by Taku Tran on 5/16/17.
//  Copyright © 2017 Taku Tran. All rights reserved.
//

import UIKit

class TableViewControllerCellTableViewCell: UITableViewCell {

    @IBOutlet var imageBox: UIImageView!
    @IBOutlet var movieName: UILabel!
    
    @IBOutlet var runtimeMin: UILabel!
    //@IBOutlet var descriptionView: UITextView!
    @IBOutlet var summary: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
