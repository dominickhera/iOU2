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
    private let animations = [AnimationType.from(direction: .bottom, offset: 100.0)]
    var selectedIndex = 0
    var loanArray: Array <AnyObject> = []
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Loan", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Loan")
        request.returnsObjectsAsFaults = false
        do {
            loanArray = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                print(data)
//            }
        } catch {
            print("failiure")
        }
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
         let totalBalanceNib = UINib(nibName: totalBalanceCellIdentifier, bundle: nil)
        collectionView.register(totalBalanceNib, forCellWithReuseIdentifier: totalBalanceCellIdentifier)
        let addNib = UINib(nibName: addCellIdentifier, bundle: nil)
        collectionView.register(addNib, forCellWithReuseIdentifier: addCellIdentifier)
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
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //        let entity = NSEntityDescription.entity(forEntityName: "Loan", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Loan")
        request.returnsObjectsAsFaults = false
        do {
            loanArray = try context.fetch(request)
            //            for data in result as! [NSManagedObject] {
            //                print(data)
            //            }
            self.collectionView.reloadData()
        } catch {
            print("failiure")
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? LoanDetailViewController {
            detailViewController.selectedIndex = self.selectedIndex
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return loanArray.count
        default:
            return 0
        }
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            self.performSegue(withIdentifier: "showCreateLoan", sender: nil)
        case 2:
            self.selectedIndex = indexPath.row
            self.performSegue(withIdentifier: "showDetail", sender: nil)
        default:
            break
        }
//        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: ( UIScreen.main.bounds.width - 3 * xInset), height: 175)
        case 1:
            return CGSize(width: ( UIScreen.main.bounds.width - 3 * xInset), height: 70)
        case 2:
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
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addCellIdentifier, for: indexPath) as! AddCollectionViewCell
//            cell.size
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loanCellIdentifier, for: indexPath) as! LoanCollectionViewCell
            let loan = loanArray[indexPath.row] as! NSManagedObject
            cell.loanAmountLabel.text = "$\((loan.value(forKey: "loanAmount"))!)"
            cell.loanContactNameLabel.text = "\((loan.value(forKey: "loanRecipient"))!)"
            cell.loanDueDateLabel.text = "\((loan.value(forKey: "dateLabel"))!)"
            cell.loanNameLabel.text = "\((loan.value(forKey: "loanNotes"))!)"
            //            cell.size
            return cell
        default:
            break
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addCellIdentifier, for: indexPath) as! AddCollectionViewCell
        return cell
    }
    
    
}
