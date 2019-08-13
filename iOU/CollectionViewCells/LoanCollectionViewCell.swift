//
//  LoanCollectionViewCell.swift
//  iOU
//
//  Created by Dominick Hera on 8/1/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import UIKit

class LoanCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var loanContactImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var loanNameLabel: UILabel!
    @IBOutlet weak var loanContactNameLabel: UILabel!
    @IBOutlet weak var loanDueDateLabel: UILabel!
    @IBOutlet weak var loanAmountLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 7
        self.layer.cornerRadius = 7
        dividerView.layer.cornerRadius = self.dividerView.frame.size.width / 2
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        self.layer.shadowOpacity = 0.16
        //        self.layer.shadowRadius = 10
        self.layer.masksToBounds = false
        
        self.loanContactImageView.layer.cornerRadius = self.loanContactImageView.frame.size.width / 2
        self.loanContactImageView.clipsToBounds = true
        self.loanContactImageView.layer.borderWidth = 2.0
        self.loanContactImageView.layer.borderColor = UIColor.white.cgColor
        // Initialization code
    }

}
