//
//  WardrobeGridViewController.swift
//  armarioViewing
//
//  Created by Carolina Santos on 11/21/21.
//

import UIKit
import Parse
import AlamofireImage

class WardrobeGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    @IBOutlet weak var gridCollectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                /// 3
        cell.backgroundColor = UIColor.red
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                  insetForSectionAt section: Int) -> UIEdgeInsets {
        /// 2
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }

    /// 3
    func collectionView(_ collectionView: UICollectionView,
                   layout collectionViewLayout: UICollectionViewLayout,
                   sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// 4
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        /// 5
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        /// 6
        return CGSize(width: widthPerItem - 8, height: 250)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func setUpCollectionView() {
         /// 1
         gridCollectionView
                .register(UICollectionViewCell.self,
                 forCellWithReuseIdentifier: "cell")

         /// 2
         gridCollectionView.delegate = self
         gridCollectionView.dataSource = self

         /// 3
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         /// 4
         layout.minimumLineSpacing = 8
         /// 5
         layout.minimumInteritemSpacing = 4

         /// 6
         gridCollectionView
               .setCollectionViewLayout(layout, animated: true)
       }
}
