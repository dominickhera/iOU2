//
//  LoanDetailViewController.swift
//  iOU
//
//  Created by Dominick Hera on 8/1/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import UIKit
import ViewAnimator

class LoanDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let itemHeight: CGFloat = 351
    private let lineSpacing: CGFloat = 10
    private let xInset: CGFloat = 10
    private let topInset: CGFloat = 10
    let cellPercentWidth: CGFloat = 0.8
    var loanDetailCellIdentifier = "LoanDetailCollectionViewCell"
    private let animations = [AnimationType.from(direction: .bottom, offset: 100.0)]
    //    @IBOutlet weak var dueDateView: UIView!
//    @IBOutlet weak var lendeeView: UIView!
//    @IBOutlet weak var loanReasonView: UIView!
    @IBOutlet weak var loanAmountLabel: UILabel!
    
    let loanTitles: [String] = ["Reason", "Lendee", "Due Date"]
    let loanDetails: [String] = ["Lunch with friends", "John Doe", "August 25th, 2019"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailNib = UINib(nibName: loanDetailCellIdentifier, bundle: nil)
        collectionView.register(detailNib, forCellWithReuseIdentifier: loanDetailCellIdentifier)
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
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: ( UIScreen.main.bounds.width - 3 * xInset), height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loanDetailCellIdentifier, for: indexPath) as! LoanDetailCollectionViewCell
        cell.detailTitleLabel.text = loanTitles[indexPath.row]
        cell.detailBodyLabel.text = loanDetails[indexPath.row]
        
        return cell
    }
    
    
}
