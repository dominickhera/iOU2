//
//  DeleteLoanCollectionViewCell.swift
//  iOU
//
//  Created by Dominick Hera on 8/27/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import UIKit

class DeleteLoanCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 7
        self.layer.cornerRadius = 7
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.shadowOpacity = 0.16
        self.layer.masksToBounds = false
        // Initialization code
    }

}
