//
//  TableViewController.swift
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    private var items: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.items = Array(1...50).map({ "Item\($0)" })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = self.items[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
