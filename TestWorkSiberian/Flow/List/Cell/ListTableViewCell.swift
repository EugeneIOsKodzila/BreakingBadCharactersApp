//
//  ListTableViewCell.swift
//  TestWorkSiberian
//
//  Created by Наташа on 05.05.2022.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func userInfoRequest(userInfo: BreakingBadCharacters?) {
        guard let userInfo = userInfo else { return }
        if let imageUrl = userInfo.img {
            photoImageView.loadFrom(URLAddress: imageUrl)
        }
        nameLabel.text = userInfo.nickname
    }
}
