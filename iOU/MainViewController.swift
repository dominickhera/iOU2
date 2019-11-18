//
//  MainViewController.swift
//  iOU
//
//  Created by Dominick Hera on 8/1/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import UIKit
import ViewAnimator
import CoreData

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let itemHeight: CGFloat = 351
    private let lineSpacing: CGFloat = 10
    private let xInset: CGFloat = 10
    private let topInset: CGFloat = 10
    let cellPercentWidth: CGFloat = 0.8
    var totalBalanceCellIdentifier = "TotalBalanceCollectionViewCell"
    var addCellIdentifier = "AddCollectionViewCell"
    var loanCellIdentifier = "LoanCollectionViewCell"
    var filterCellIdentifier = "FilterCollectionViewCell"
    private let animations = [AnimationType.from(direction: .bottom, offset: 100.0)]
    var selectedIndex = 0
//    var totalAmountOwed: Double = 0.00
//    var loanArray: Array <AnyObject> = []
//    var loanArray: [LoanModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
////        let entity = NSEntityDescription.entity(forEntityName: "Loan", in: context)
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Loan")
//        request.returnsObjectsAsFaults = false
//        do {
//            loanArray.removeAll()
//            let tempLoanArray = try context.fetch(request)
//            totalAmountOwed = 0.0
//            for data in tempLoanArray as! [NSManagedObject] {
////                print(data)
//                let amountOwed = data.value(forKey: "loanAmount") as! String
//                let loanNotes = data.value(forKey: "loanNotes") as! String
//                let loanRecipient = data.value(forKey: "loanRecipient") as! String
//                let dateLabel = data.value(forKey: "dateLabel") as! String
//                let newLoan = LoanModel(loanAmount: amountOwed, loanNotes: loanNotes, loanRecipient: loanRecipient, dateLabel: dateLabel)
//                loanArray.append(newLoan)
//                totalAmountOwed += Double(amountOwed) ?? 0
////                totalAmountOwed += data.value(forKey: "loanAmount") as! Double
//
//            }
//
//        } catch {
//            print("failiure")
//        }
        
        LoanManager.shared.retrieveLoanList()
        LoanManager.shared.loanList.sort(by: LoanManager.shared.sortByNewest(this:that:))
//        loanArray.sort(by: sortByNewest(this:that:))
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
         let totalBalanceNib = UINib(nibName: totalBalanceCellIdentifier, bundle: nil)
        collectionView.register(totalBalanceNib, forCellWithReuseIdentifier: totalBalanceCellIdentifier)
        let addNib = UINib(nibName: addCellIdentifier, bundle: nil)
        collectionView.register(addNib, forCellWithReuseIdentifier: addCellIdentifier)
        let filterNib = UINib(nibName: filterCellIdentifier, bundle: nil)
        collectionView.register(filterNib, forCellWithReuseIdentifier: filterCellIdentifier)
        let loanNib = UINib(nibName: loanCellIdentifier, bundle: nil)
        collectionView.register(loanNib, forCellWithReuseIdentifier: loanCellIdentifier)
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
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("hello")
    }
    override func viewWillAppear(_ animated: Bool) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        //        let entity = NSEntityDescription.entity(forEntityName: "Loan", in: context)
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Loan")
//        request.returnsObjectsAsFaults = false
//        do {
//            let tempLoanArray = try context.fetch(request)
//            totalAmountOwed = 0.0
//            loanArray.removeAll()
//            for data in tempLoanArray as! [NSManagedObject] {
//                let amountOwed = data.value(forKey: "loanAmount") as! String
//                let loanNotes = data.value(forKey: "loanNotes") as! String
//                let loanRecipient = data.value(forKey: "loanRecipient") as! String
//                let dateLabel = data.value(forKey: "dateLabel") as! String
//                let newLoan = LoanModel(loanAmount: amountOwed, loanNotes: loanNotes, loanRecipient: loanRecipient, dateLabel: dateLabel)
//                loanArray.append(newLoan)
//                totalAmountOwed += Double(amountOwed) ?? 0
//
//            }
//            self.collectionView.reloadData()
//        } catch {
//            print("failiure")
//        }
        LoanManager.shared.retrieveLoanList()
        self.collectionView.reloadData()
    }
    
    func sortByHighest(this: LoanModel, that: LoanModel) -> Bool {
        return (Double(this.loanAmount)!.isLess(than: Double(that.loanAmount) as! Double))
    }

    func sortByLowest(this: LoanModel, that: LoanModel) -> Bool {
        return (Double(that.loanAmount)!.isLess(than: Double(this.loanAmount) as! Double))
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? LoanDetailViewController {
//            detailViewController.selectedIndex = self.selectedIndex
            detailViewController.loan = LoanManager.shared.loanList[self.selectedIndex]
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, sortDelegate {
    func sortLoansBy(sortMethod: String) {
        print(sortMethod)
        switch sortMethod {
        case "new":
            LoanManager.shared.loanList.sort(by: LoanManager.shared.sortByNewest(this:that:))
        case "old":
            LoanManager.shared.loanList.sort(by: LoanManager.shared.sortByOldest(this:that:))
        case "low":
            LoanManager.shared.loanList.sort(by: LoanManager.shared.sortByLowest(this:that:))
        case "high":
            LoanManager.shared.loanList.sort(by: LoanManager.shared.sortByHighest(this:that:))
        default:
            return
        }
        self.collectionView.reloadData()
//        let tempIndexSet = IndexSet(integer: 3)
//        self.collectionView.reloadSections(tempIndexSet)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return LoanManager.shared.loanList.count
        default:
            return 0
        }
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            self.performSegue(withIdentifier: "showCreateLoan", sender: nil)
        case 3:
            self.selectedIndex = LoanManager.shared.loanList.count - indexPath.row - 1
            self.performSegue(withIdentifier: "showDetail", sender: nil)
        default:
            break
        }
//        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: ( UIScreen.main.bounds.width - 3 * xInset), height: 175)
        case 1:
            return CGSize(width: ( UIScreen.main.bounds.width - 3 * xInset), height: 70)
        case 2:
            return CGSize(width: ( UIScreen.main.bounds.width - 3 * xInset), height: 35)
        case 3:
            return CGSize(width: ( UIScreen.main.bounds.width - 3 * xInset), height: 80)
        default:
            break
        }
        return CGSize(width: 64, height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: totalBalanceCellIdentifier, for: indexPath) as! TotalBalanceCollectionViewCell
            cell.totalAmountOwedLabel.text = String(format: "$%.2f", LoanManager.shared.totalAmountOwed)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addCellIdentifier, for: indexPath) as! AddCollectionViewCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellIdentifier, for: indexPath) as! FilterCollectionViewCell
            //            cell.size
            cell.delegate = self
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loanCellIdentifier, for: indexPath) as! LoanCollectionViewCell
            let loan = LoanManager.shared.loanList[LoanManager.shared.loanList.count - indexPath.row - 1]
            cell.loanAmountLabel.text = "$\((loan.loanAmount))"
            cell.loanContactNameLabel.text = "\(loan.loanRecipient)"
            cell.loanDueDateLabel.text = "\((loan.dateLabel))"
            cell.loanNameLabel.text = "\(loan.loanNotes)"
            //            cell.size
            return cell
        default:
            break
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addCellIdentifier, for: indexPath) as! AddCollectionViewCell
        return cell
    }
    
    
}
