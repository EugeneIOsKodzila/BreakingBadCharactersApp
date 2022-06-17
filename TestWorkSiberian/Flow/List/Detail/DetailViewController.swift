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
    var charId: Int?
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }
    
    func requestData() {
        guard let id = charId else {return}
        networkService.request(urlString: networkService.urlBreakingBadApi + String(id)) { [weak self] result in
            switch result {
            case .success(let breakingbadCharacters):
                guard let self = self else { return }
                guard let actor = breakingbadCharacters.first else {return}
                self.setupActorData(actorData: actor)
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    private func setupActorData(actorData: BreakingBadCharacters) {
        nameLabel.text = actorData.name
        birthdayLabel.text = actorData.birthday
        let url = URL(string: "\(actorData.img)")
        characterImage.kf.setImage(with: url)
        occupationLabel.text = actorData.occupation[0]
        portrayedLabel.text = actorData.portrayed
    }
}
