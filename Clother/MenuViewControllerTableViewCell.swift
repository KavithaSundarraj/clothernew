//
//  MenuViewControllerTableViewCell.swift
//  Clother
//
//  Created by DSV on 2018-04-19.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit

class MenuViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var CollectionName: UILabel!
    @IBOutlet weak var CollectionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
