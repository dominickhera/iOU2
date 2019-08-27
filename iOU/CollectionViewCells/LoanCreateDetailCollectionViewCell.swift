//
//  LoanCreateDetailCollectionViewCell.swift
//  iOU
//
//  Created by Dominick Hera on 8/20/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import UIKit

class LoanCreateDetailCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
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
        self.layer.masksToBounds = false
        detailBodyTextField.delegate = self
        detailBodyTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc func textDidChange(textField: UITextField) {
        if (detailTitleLabel.text == "Due Date") {
            guard let detailText = detailBodyTextField.text else
            {
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch detailTitleLabel.text {
        case "Due Date":
            
            let picker : UIDatePicker = UIDatePicker()
            picker.datePickerMode = UIDatePicker.Mode.date
            picker.addTarget(self, action: #selector(dueDateChanged(sender:)), for: UIControl.Event.valueChanged)
            picker.frame = CGRect(x:0.0, y:picker.frame.height + 20, width:self.frame.width, height:picker.frame.height + 20)
            detailBodyTextField.inputView = picker
        default:
            break
        }
    }
    
    @objc func dueDateChanged(sender:UIDatePicker){
        if (detailTitleLabel.text == "Due Date") {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            self.detailBodyTextField.text = (dateFormatter.string(from: sender.date))
            
            print("sender date: <\(sender.date)>")
            guard let detailText = detailBodyTextField.text else
            {
                return
            }
        }
    }
    
    @objc func setDueDate() {
        if (!(self.detailBodyTextField.text)!.isEmpty) {
            self.endEditing(true)
        }
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if detailTitleLabel.text == "Due Date" {
            self.detailBodyTextField.resignFirstResponder()
        }
        return true
    }

}
