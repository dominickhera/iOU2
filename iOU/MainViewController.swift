//
//  MainViewController.swift
//  iOU
//
//  Created by Dominick Hera on 8/1/19.
//  Copyright © 2019 Dominick Hera. All rights reserved.
//

import UIKit
import ViewAnimator

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
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController.na
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
            return 8
        default:
            return 0
        }
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            print("add new loan")
        case 2:
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
            //            cell.size
            return cell
        default:
            break
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addCellIdentifier, for: indexPath) as! AddCollectionViewCell
        return cell
    }
    
    
}
