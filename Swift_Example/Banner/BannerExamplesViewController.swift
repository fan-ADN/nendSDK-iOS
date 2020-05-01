//
//  BannerExamplesViewController.swift
//  Swift_Example
//
//  Created by 鈴木航 on 2020/04/28.
//  Copyright © 2020 FAN Communications. All rights reserved.
//

import UIKit

class BannerExamplesViewController: UITableViewController {
    let items = [
        (name: "320x50", segue: "PushMobileBigBanner"),
        (name: "320x100", segue: "PushMobileBanner"),
        (name: "300x100", segue: "PushThreeOneRectangle"),
        (name: "300x250", segue: "PushMediumRectangle"),
        (name: "728x90", segue: "PushBigBanner")
    ]
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BannerExamplesCell", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = self.items[indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: self.items[indexPath.row].segue, sender: nil)
    }

}
