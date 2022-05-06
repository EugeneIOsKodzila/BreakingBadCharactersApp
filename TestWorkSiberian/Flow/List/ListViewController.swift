//
//  ListViewController.swift
//  TestWorkSiberian
//
//  Created by Наташа on 02.05.2022.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView?.dataSource = self
            listTableView?.delegate = self
            listTableView?.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        
        return cell
    }
    
    
}
