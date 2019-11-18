//
//  LoanManager.swift
//  iOU
//
//  Created by Dominick Hera on 11/18/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class LoanManager {
    static let shared = LoanManager()
    var loanList: [LoanModel] = []
    var totalAmountOwed: Double = 0.0
    
    private init() {}
    
    func retrieveLoanList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Loan")
        request.returnsObjectsAsFaults = false
        do {
            let tempLoanArray = try context.fetch(request)
            totalAmountOwed = 0.0
            loanList.removeAll()
            for data in tempLoanArray as! [NSManagedObject] {
                let amountOwed = data.value(forKey: "loanAmount") as! String
                let loanNotes = data.value(forKey: "loanNotes") as! String
                let loanRecipient = data.value(forKey: "loanRecipient") as! String
                let dateLabel = data.value(forKey: "dateLabel") as! String
                let newLoan = LoanModel(loanAmount: amountOwed, loanNotes: loanNotes, loanRecipient: loanRecipient, dateLabel: dateLabel)
                loanList.append(newLoan)
                totalAmountOwed += Double(amountOwed) ?? 0
            }
            
        } catch {
            print("failiure")
        }
    }
    
    func sortByHighest(this: LoanModel, that: LoanModel) -> Bool {
        return (Double(this.loanAmount)!.isLess(than: Double(that.loanAmount)!))
    }

    func sortByLowest(this: LoanModel, that: LoanModel) -> Bool {
        return (Double(that.loanAmount)!.isLess(than: Double(this.loanAmount)!))
    }
    
    func sortByNewest(this: LoanModel, that: LoanModel) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let thisDate = dateFormatter.date(from: this.dateLabel)
        let thatDate = dateFormatter.date(from: that.dateLabel)
        return thisDate! < thatDate!
    }
    
    func sortByOldest(this: LoanModel, that: LoanModel) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let thisDate = dateFormatter.date(from: this.dateLabel)
        let thatDate = dateFormatter.date(from: that.dateLabel)
        return thisDate! > thatDate!
    }
}
