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
    var breakingBadCharacters: [BreakingBadCharacters] = []
    
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView?.dataSource = self
            listTableView?.delegate = self
            listTableView?.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RequestBreakingBad()
    }
    
    func RequestBreakingBad() {
        networkService.request(urlString: networkService.UrlBreakingBadApi) { [weak self] result in
            switch result {
            case .success(let breakingbadCharacters):
                guard let self = self else { return }
                self.breakingBadCharacters = breakingbadCharacters
                self.listTableView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breakingBadCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let userInfo = breakingBadCharacters[indexPath.row]
        cell.UserInfoRequest(userInfo: userInfo)
        return cell
    }
}
