//
//  ProductDetailsTableViewCell.swift
//  tableViewSampleApp
//
//  Created by webonise on 28/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit
class ProductDetailsTableViewCell: UITableViewCell {

    @IBOutlet var labelProductName: UILabel!
    @IBOutlet var labelProductPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
