//
//  PostCellTableViewCell.swift
//  armarioViewing
//
//  Created by Carolina Santos on 11/15/21.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    var liked = false
    var likesCount = 5;
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        print("like button tapped")
        
        if (!liked) {
            self.setLiked(true)
        } else {
            self.setLiked(false)
        }
    }
    
    func setLiked(_ isLiked:Bool) {
        liked = isLiked
        if (liked) {
            likesCount += 1
            likeCountLabel.text = "\(likesCount) Likes"
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            likesCount -= 1
            likeCountLabel.text = "\(likesCount) Likes"
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
