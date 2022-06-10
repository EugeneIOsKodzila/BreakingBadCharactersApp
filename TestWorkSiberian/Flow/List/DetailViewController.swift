//
//  DetailViewController.swift
//  TestWorkSiberian
//
//  Created by Наташа on 10.06.2022.
//
import Foundation
import UIKit
import Kingfisher


class DetailViewController: UIViewController {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var portrayedLabel: UILabel!
    
    var character:BreakingBadCharacters!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "\(character.img)")
        nameLabel.text = character?.name
        birthdayLabel.text = character?.birthday
        occupationLabel.text = character?.occupation[0]
        portrayedLabel.text = character?.portrayed
        characterImage.kf.setImage(with: url)
        
    }
}
