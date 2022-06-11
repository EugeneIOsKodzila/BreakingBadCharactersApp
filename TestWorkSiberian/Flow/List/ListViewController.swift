//
//  ListViewController.swift
//  TestWorkSiberian
//
//  Created by Наташа on 02.05.2022.
//

import Foundation
import UIKit

class ListViewController: UIViewController, UISearchControllerDelegate {
    let networkService = NetworkService()
    var breakingBadCharacters: [BreakingBadCharacters] = []
    var filteredCharacters = [BreakingBadCharacters]()
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    @IBOutlet weak var noResultLabel: UILabel! {
        didSet {
            noResultLabel.alpha = 0
        }
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
        searchController.delegate = self
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {self.searchController.searchBar.becomeFirstResponder()})
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
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarIsEmpty {
            noResultLabel.alpha = 0
            return breakingBadCharacters.count
        }
        if filteredCharacters.isEmpty {
            noResultLabel.alpha = 1
        } else {
            noResultLabel.alpha = 0
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            if searchBarIsEmpty {
                destination.character = breakingBadCharacters[(listTableView.indexPathForSelectedRow?.row)!]
            } else {
                destination.character = filteredCharacters[(listTableView.indexPathForSelectedRow?.row)!]
            }
        }
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
