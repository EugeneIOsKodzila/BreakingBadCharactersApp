//
//  ListTableViewCell.swift
//  TestWorkSiberian
//
//  Created by Наташа on 05.05.2022.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func userInfoRequest(userInfo: BreakingBadCharacters?) {
        guard let userInfo = userInfo else { return }
        if let imageUrl = userInfo.img {
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(with: URL(string:imageUrl), placeholder: nil, options: [.transition(.fade(0.7))], completionHandler: nil)
        }
        nameLabel.text = userInfo.nickname
        cellAddon()
    }
    
    func cellAddon() {
        layer.borderWidth = CGFloat(1.5)
        layer.borderColor = UIColor.white.cgColor
        photoImageView.contentMode = .scaleAspectFill
    }
}
