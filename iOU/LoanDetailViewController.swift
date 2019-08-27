//
//  LoanDetailViewController.swift
//  iOU
//
//  Created by Dominick Hera on 8/1/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import UIKit
import ViewAnimator
import CoreData

class LoanDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let itemHeight: CGFloat = 351
    private let lineSpacing: CGFloat = 10
    private let xInset: CGFloat = 10
    private let topInset: CGFloat = 10
    let cellPercentWidth: CGFloat = 0.8
    var loan: LoanModel?
    var loanDetailCellIdentifier = "LoanDetailCollectionViewCell"
    var editLoanCellIdentifier = "EditDetailCollectionViewCell"
    var deleteLoanCellIdentifier = "DeleteLoanCollectionViewCell"
    private let animations = [AnimationType.from(direction: .bottom, offset: 100.0)]
    //    @IBOutlet weak var dueDateView: UIView!
//    @IBOutlet weak var lendeeView: UIView!
//    @IBOutlet weak var loanReasonView: UIView!
    @IBOutlet weak var loanAmountLabel: UILabel!
    var selectedIndex = 0
    let loanTitles: [String] = ["Reason", "Lendee", "Due Date"]
//    let loanDetails: [String] = ["Lunch with friends", "John Doe", "August 25th, 2019"]
    var loanDetails: [String] = []
    var loanArray: Array <AnyObject> = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        //        let entity = NSEntityDescription.entity(forEntityName: "Loan", in: context)
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Loan")
//        request.returnsObjectsAsFaults = false
//        do {
//            loanArray = try context.fetch(request)
//            let loan = loanArray[selectedIndex] as! NSManagedObject
//            self.loanAmountLabel.text = "$\((loan.value(forKey: "loanAmount"))!)"
//           let loanContact = "\((loan.value(forKey: "loanRecipient"))!)"
//            let dueDate = "\((loan.value(forKey: "dateLabel"))!)"
//            let loanNotes  = "\((loan.value(forKey: "loanNotes"))!)"
        loanDetails.append(loan!.loanNotes)
        loanDetails.append(loan!.loanRecipient)
        loanDetails.append(loan!.dateLabel)
        loanAmountLabel.text = "$\(loan!.loanAmount)"
//                        for data in loanArray[selectedIndex] as! NSManagedObject {
//                            print(data)
//                        }
//        } catch {
//            print("failiure")
//        }
        let detailNib = UINib(nibName: loanDetailCellIdentifier, bundle: nil)
        collectionView.register(detailNib, forCellWithReuseIdentifier: loanDetailCellIdentifier)
        let editNib = UINib(nibName: editLoanCellIdentifier, bundle: nil)
        collectionView.register(editNib, forCellWithReuseIdentifier: editLoanCellIdentifier)
        let deleteNib = UINib(nibName: deleteLoanCellIdentifier, bundle: nil)
        collectionView.register(deleteNib, forCellWithReuseIdentifier: deleteLoanCellIdentifier)
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.minimumLineSpacing = lineSpacing
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        collectionView?.performBatchUpdates({
            UIView.animate(views: self.collectionView!.orderedVisibleCells,
                           animations: animations, completion: nil)
        }, completion: nil)
//        loanReasonView.layer.cornerRadius = 7
//        loanReasonView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        loanReasonView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
//        loanReasonView.layer.shadowOpacity = 0.16
//        //        self.layer.shadowRadius = 10
//        loanReasonView.layer.masksToBounds = false
//        lendeeView.layer.cornerRadius = 7
//        lendeeView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        lendeeView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
//        lendeeView.layer.shadowOpacity = 0.16
//        //        self.layer.shadowRadius = 10
//        lendeeView.layer.masksToBounds = false
//        dueDateView.layer.cornerRadius = 7
//        dueDateView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        dueDateView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
//        dueDateView.layer.shadowOpacity = 0.16
//        //        self.layer.shadowRadius = 10
//        dueDateView.layer.masksToBounds = false
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoanDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return 1
        }
//        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
        return CGSize(width: ( UIScreen.main.bounds.width - 3 * xInset), height: 80)
            
        default:
             return CGSize(width: ( UIScreen.main.bounds.width - 3 * xInset), height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loanDetailCellIdentifier, for: indexPath) as! LoanDetailCollectionViewCell
//        let loan = loanArray[selectedIndex] as! NSManagedObject
        cell.detailTitleLabel.text = loanTitles[indexPath.row]
        cell.detailBodyLabel.text = loanDetails[indexPath.row]
        
        return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: editLoanCellIdentifier, for: indexPath) as! EditDetailCollectionViewCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: deleteLoanCellIdentifier, for: indexPath) as! DeleteLoanCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: deleteLoanCellIdentifier, for: indexPath) as! DeleteLoanCollectionViewCell
            return cell
        }
    }
    
    
}
