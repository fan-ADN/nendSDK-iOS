//
//  FullBoardAdMenuViewController.swift
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

import UIKit

class FullBoardAdMenuViewController: UITableViewController {
    
    private let items = [
        (name: "インタースティシャル形式", segue: "PushDefault", detail: "ポップアップで表示された広告は右上の×ボタンにより閉じることができます。"),
        (name: "スワイプ形式", segue: "PushPage", detail: "マンガや小説などスワイプでページ送りをするアプリにてページとページの間に広告を差し込むことができます。※×ボタンは非表示にできます。"),
        (name: "スクロールエンド形式", segue: "PushWeb", detail: "ニュースや記事まとめ、縦スクロール式のマンガアプリなどで最下部までスクロールした後に画面下部から広告を呼び出します。右上の×ボタンにて閉じることができます。"),
        (name: "タブ形式", segue: "PushTab", detail: "ニュースや記事まとめアプリでカテゴリタブの中に\"PR\"タブを作成し、PRタブがタップされた際に広告を表示します。")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "FullBoard"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = self.items[indexPath.row].name
            content.secondaryText = self.items[indexPath.row].detail
            cell.contentConfiguration = content
        } else {
            cell.textLabel!.text = self.items[indexPath.row].name
            if let detailTextLabel = cell.detailTextLabel {
                detailTextLabel.numberOfLines = 0
                detailTextLabel.text = self.items[indexPath.row].detail
            }
        }
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: self.items[indexPath.row].segue, sender: indexPath)
    }    
}
