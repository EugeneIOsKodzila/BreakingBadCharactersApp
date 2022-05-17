//
//  ListTableViewCell.swift
//  TestWorkSiberian
//
//  Created by Наташа on 05.05.2022.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func userInfoRequest(userInfo: BreakingBadCharacters?) {
        guard let userInfo = userInfo else { return }
        if let imageUrl = userInfo.img {
            photoImageView.loadFrom(URLAddress: imageUrl)
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
        }
        nameLabel.text = userInfo.nickname
        layer.borderWidth = CGFloat(1.5)
        layer.borderColor = UIColor.white.cgColor
        photoImageView.contentMode = .scaleAspectFill
        
    }
}
