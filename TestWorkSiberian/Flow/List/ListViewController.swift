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
    var filteredCharacters = [BreakingBadCharacters]()
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView?.dataSource = self
            listTableView?.delegate = self
            listTableView?.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        requestBreakingBad()
    }
    
    func requestBreakingBad() {
        networkService.request(urlString: networkService.urlBreakingBadApi) { [weak self] result in
            switch result {
            case .success(let breakingbadCharacters):
                guard let self = self else { return }
                self.breakingBadCharacters = breakingbadCharacters
                self.listTableView.reloadData()
            case .failure(let error):
                self?.fetchData()
                print("error", error)
            }
        }
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func fetchData(){
        guard let fileLocation = Bundle.main.url(forResource: "localDataBB", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: fileLocation)
            let receivedData = try JSONDecoder().decode([BreakingBadCharacters].self, from: data)
            self.breakingBadCharacters = receivedData
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        } catch {
            print("Error while decoding JSON")
        }
    }
    
    func setupNoDataLabel() {
        let emptyLabel = UILabel()
        emptyLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        emptyLabel.text = "Ooooops no result"
        emptyLabel.textAlignment = NSTextAlignment.center
        self.listTableView.backgroundView = emptyLabel
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarIsEmpty {
            return breakingBadCharacters.count
        }
        if tableView.visibleCells.isEmpty {
            setupNoDataLabel()
        } else {
            self.listTableView.backgroundView = nil
        }
        return filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        if searchBarIsEmpty {
            let userInfo = breakingBadCharacters[indexPath.row]
            cell.set(userInfo: userInfo)
            return cell
        }
        let userInfo = filteredCharacters[indexPath.row]
        cell.set(userInfo: userInfo)
        return cell
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCharacters = searchText.isEmpty ? breakingBadCharacters:breakingBadCharacters.filter {
            (item: BreakingBadCharacters) -> Bool in return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        listTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        listTableView.reloadData()
    }
}
