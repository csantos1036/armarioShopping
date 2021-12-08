//
//  ProfileViewController.swift
//  armarioViewing
//
//  Created by Carolina Santos on 11/21/21.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var posts = [PFObject]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.posts.reverse()
                self.gridCollectionView.reloadData()
            }        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewDidAppear(true)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as! GridCollectionViewCell
        
        /*
        if post["author"] as! NSObject == PFUser.current()! {
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            cell.imageView.af_setImage(withURL: url)
        }
         */
        
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
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var gridCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()!
        usernameLabel.text = user.username
        
        let imageFile = user["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        profileImage.af_setImage(withURL: url)
        
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
                .register(GridCollectionViewCell.self,
                 forCellWithReuseIdentifier: "GridCollectionViewCell")

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

