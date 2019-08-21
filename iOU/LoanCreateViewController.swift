//
//  LoanCreateViewController.swift
//  iOU
//
//  Created by Dominick Hera on 8/21/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import UIKit
import ViewAnimator

class LoanCreateViewController: UIViewController {

    @IBOutlet weak var saveCreateButton: UIButton!
    @IBOutlet weak var cancelCreateButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var amountOwedTextField: UITextField!
    
    private let itemHeight: CGFloat = 351
    private let lineSpacing: CGFloat = 10
    private let xInset: CGFloat = 10
    private let topInset: CGFloat = 10
    let cellPercentWidth: CGFloat = 0.8
    var loanCreateCellIdentifier = "LoanCreateDetailCollectionViewCell"
    private let animations = [AnimationType.from(direction: .bottom, offset: 100.0)]
    let loanTitles: [String] = ["Reason", "Lendee", "Due Date"]
    let loanDetails: [String] = ["Lunch with friends", "John Doe", "August 25th, 2019"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let createNib = UINib(nibName: loanCreateCellIdentifier, bundle: nil)
        collectionView.register(createNib, forCellWithReuseIdentifier: loanCreateCellIdentifier)
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
    

    @IBAction func cancelCreateNewLoan(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
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
extension LoanCreateViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: ( UIScreen.main.bounds.width - 3 * xInset), height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loanCreateCellIdentifier, for: indexPath) as! LoanCreateDetailCollectionViewCell
        cell.detailTitleLabel.text = loanTitles[indexPath.row]
        cell.detailBodyTextField.placeholder = loanDetails[indexPath.row]
//        cell.detailBodyLabel.text = loanDetails[indexPath.row]
        
        return cell
    }
    
    
}
