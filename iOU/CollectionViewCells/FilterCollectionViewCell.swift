//
//  FilterCollectionViewCell.swift
//  iOU
//
//  Created by Dominick Hera on 8/27/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import UIKit

protocol sortDelegate {
    func sortLoansBy(sortMethod: String)
}


class FilterCollectionViewCell: UICollectionViewCell {
    var delegate: sortDelegate?
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var filterNewView: UIView!
    @IBOutlet weak var filterOldView: UIView!
    @IBOutlet weak var filterHighView: UIView!
    @IBOutlet weak var filterLowView: UIView!
    var sortMethod = "new"
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 7
        self.layer.cornerRadius = 7
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.shadowOpacity = 0.16
        self.layer.masksToBounds = false
        self.filterNewView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sortByNew)))
        self.filterOldView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sortByOld)))
        self.filterHighView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sortByHigh)))
        self.filterLowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sortByLow)))
        // Initialization code
    }
    
    @objc func sortByNew() {
        sortMethod = "new"
        self.filterLoans(Any.self)
    }
    
    @objc func sortByOld() {
        sortMethod = "old"
        self.filterLoans(Any.self)
    }
    
    @objc func sortByHigh() {
        sortMethod = "high"
        self.filterLoans(Any.self)
    }
    
    @objc func sortByLow() {
        sortMethod = "low"
        self.filterLoans(Any.self)
    }
    
    func updateSelected() {
        switch sortMethod {
        case "new":
            filterNewView.backgroundColor = UIColor.lightGray
            filterOldView.backgroundColor = UIColor.white
            filterHighView.backgroundColor = UIColor.white
            filterLowView.backgroundColor = UIColor.white
        case "old":
            filterNewView.backgroundColor = UIColor.white
            filterOldView.backgroundColor = UIColor.lightGray
            filterHighView.backgroundColor = UIColor.white
            filterLowView.backgroundColor = UIColor.white
        case "high":
            filterNewView.backgroundColor = UIColor.white
            filterOldView.backgroundColor = UIColor.white
            filterHighView.backgroundColor = UIColor.lightGray
            filterLowView.backgroundColor = UIColor.white
        case "low":
            filterNewView.backgroundColor = UIColor.white
            filterOldView.backgroundColor = UIColor.white
            filterHighView.backgroundColor = UIColor.white
            filterLowView.backgroundColor = UIColor.lightGray
        default:
            return
        }
    }

}

extension FilterCollectionViewCell {
    @IBAction func filterLoans(_ sender: Any) {
        self.updateSelected()
        delegate?.sortLoansBy(sortMethod: sortMethod)
    }
}
