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
    var char_id: Int!
    var character:BreakingBadCharacters!
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }
    
    func requestData() {
        guard let id = char_id else {return}
        networkService.request(urlString: networkService.urlBreakingBadApi + String(id)) { [weak self] result in
            switch result {
            case .success(let breakingbadCharacters):
                guard let self = self else { return }
                guard let actor = breakingbadCharacters.first else {return}
                self.nameLabel.text = actor.name
                self.birthdayLabel.text = actor.birthday
                let url = URL(string: "\(actor.img)")
                self.characterImage.kf.setImage(with: url)
                self.occupationLabel.text = actor.occupation[0]
                self.portrayedLabel.text = actor.portrayed
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
