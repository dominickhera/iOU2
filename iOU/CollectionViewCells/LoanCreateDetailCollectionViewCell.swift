//
//  LoanCreateDetailCollectionViewCell.swift
//  iOU
//
//  Created by Dominick Hera on 8/20/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import UIKit

class LoanCreateDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var detailBodyTextField: UITextField!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 7
        self.layer.cornerRadius = 7
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        self.layer.shadowOpacity = 0.16
        //        self.layer.shadowRadius = 10
        self.layer.masksToBounds = false
    }

}
