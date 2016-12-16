//
//  TipsCell.swift
//  aynelgul-pset6
//
//  Created by Aynel Gül on 15-12-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit

class TipsCell: UITableViewCell {

    // MARK: Outlets.
    @IBOutlet weak var tipsTextField: UITextField!
    
    // MARK: Functions.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
