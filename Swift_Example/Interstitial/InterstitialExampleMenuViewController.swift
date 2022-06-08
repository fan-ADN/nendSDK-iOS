//
//  InterstitialExampleMenuViewController.swift
//  Swift_Example
//
//  Created by 鈴木航 on 2020/04/28.
//  Copyright © 2020 FAN Communications. All rights reserved.
//

import UIKit

class InterstitialExampleMenuViewController: UITableViewController {

    let items = [
        (name: "Normal", segue: "PushInterstitialAd"),
        (name: "In Transition", segue: "PushInterstitialAdInTransition")
    ]
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InterstitialExampleCell", for: indexPath)

        // Configure the cell...
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = self.items[indexPath.row].name
            cell.contentConfiguration = content
        } else {
            cell.textLabel!.text = self.items[indexPath.row].name
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: self.items[indexPath.row].segue, sender: nil)
    }

}
