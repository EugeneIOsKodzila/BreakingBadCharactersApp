//
//  ListViewController.swift
//  TestWorkSiberian
//
//  Created by Наташа on 02.05.2022.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    let networkService = NetworkService()
    var urlResponse: [UrlResponse]? = nil
    
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView?.dataSource = self
            listTableView?.delegate = self
            listTableView?.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://www.breakingbadapi.com/api/characters/"
        networkService.request(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let urlResponse):
                self?.urlResponse = urlResponse
                self?.listTableView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let userInfo = urlResponse?[indexPath.row]
        if let imageUrl = userInfo?.img {
            cell.photoImageView.loadFrom(URLAddress: imageUrl)
        } else {
            print("image not load")
        }
        cell.textLabel?.text = userInfo?.nickname
        return cell
    }
    
    
}
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else { return }
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
