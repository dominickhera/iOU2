//
//  Loan.swift
//  iOU
//
//  Created by Dominick Hera on 8/27/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import Foundation

class LoanModel {
    var loanAmount: String = ""
    var loanNotes: String = ""
    var loanRecipient: String = ""
    var dateLabel: String = ""
    
    init(loanAmount: String, loanNotes: String, loanRecipient: String, dateLabel: String) {
        self.loanAmount = loanAmount
        self.loanNotes = loanNotes
        self.loanRecipient = loanRecipient
        self.dateLabel = dateLabel
    }
    
}
