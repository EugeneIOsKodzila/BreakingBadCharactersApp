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
    
    func set(userInfo: BreakingBadCharacters?) {
        guard let userInfo = userInfo else { return }
        let url = URL(string: userInfo.img)
        photoImageView.kf.indicatorType = .activity
        photoImageView.kf.setImage(with: url)
        nameLabel.text = userInfo.name
        setupCell()
    }
    
    func setupCell() {
        layer.borderWidth = CGFloat(1.5)
        layer.borderColor = UIColor.white.cgColor
        photoImageView.contentMode = .scaleAspectFill
    }
}
