//
//  NativeAdRssTableViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeAdRssTableViewController: UITableViewController, NADNativeTableViewHelperDelegate {
    
    fileprivate struct Feed {
        let isAd: Bool
        let title: String
        let category: String
        let link: String
    }
    
    fileprivate var items = [[Feed]]()
    fileprivate var helper: NADNativeTableViewHelper!
    
    deinit {
        print("NativeAdRssTableViewController: deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "RSS"
        self.tableView.allowsSelection = false
        
        self.tableView.register(UINib(nibName: "FeedCell1", bundle: nil), forCellReuseIdentifier: "FeedCell1")
        self.tableView.register(UINib(nibName: "FeedCell2", bundle: nil), forCellReuseIdentifier: "FeedCell2")
        self.tableView.register(UINib(nibName: "FeedCell3", bundle: nil), forCellReuseIdentifier: "FeedCell3")
        self.tableView.register(UINib(nibName: "FeedCell4", bundle: nil), forCellReuseIdentifier: "FeedCell4")

        self.tableView.register(UINib(nibName: "FeedAdCell", bundle: nil), forCellReuseIdentifier: "FeedAdCell")
        self.tableView.register(UINib(nibName: "FeedWithAdCell2", bundle: nil), forCellReuseIdentifier: "FeedWithAdCell2")
        self.tableView.register(UINib(nibName: "FeedWithAdCell3", bundle: nil), forCellReuseIdentifier: "FeedWithAdCell3")
        
        var items = [Feed]()
        
        for _ in 1...50 {
            let random = arc4random_uniform(2)
            if 0 == random {
                items.append(Feed(isAd: false, title: "nendバナーカスタマイズ事例",
                    category: "ニュースリリース", link: "http://adn-mobasia.net/archives/1318"))
            } else {
                items.append(Feed(isAd: false, title: "スマホでプレイ中のゲームの攻略情報を自動配信と検索で一つに集約できるアプリ「ゲーマグ」提供開始",
                    category: "ニュースリリース", link: "http://gamag.jp/"))
            }
        }
        
        // 広告表示位置にダミーのFeedを追加
        let adSpace = Feed(isAd: true, title: "", category: "", link: "")
        items.insert(adSpace, at: 4)
        items.insert(adSpace, at: 6)
        items.insert(adSpace, at: 9)
        self.items += self.createDateSource(items)
        self.tableView.reloadData()
        
        let placer = NADNativeTableViewPlacement()
        // 1行目は2つの広告を取得したFeedと一緒に表示
        placer.addFixedIndexPath(IndexPath(row: 1, section: 0), fillRow: false, adCount: 2)
        // 3行目は1つの広告を取得したFeedと一緒に表示
        placer.addFixedIndexPath(IndexPath(row: 3, section: 0), fillRow: false)
        // 6行目は広告行のみ
        placer.addFixedIndexPath(IndexPath(row: 6, section: 0))
        
        self.helper = NADNativeTableViewHelper(tableView: self.tableView, spotId: "485507", apiKey: "31e861edb574cfa0fb676ebdf0a0b9a0621e19fc", advertisingExplicitly: .PR, adPlacement: placer, delegate: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 引数のindexPathをそのまま使用
        let feeds = self.items[indexPath.row]
        let identifier = "FeedCell\(feeds.count)"
        // 広告行を含んだindexPathに変換しセルを取得
        let reuseIndexPath = self.helper.actualIndexPath(forOriginalIndexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: reuseIndexPath!)

        // Configure the cell...
        self.bindFeeds(feeds, intoCell: cell)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.items[indexPath.row].count {
        case 1:
            return 80.0
        case 2:
            return 140.0
        case 3:
            return 160.0
        case 4:
            return 211.0
        default:
            return 0.0
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }

    // MARK: - NADNativeTableViewHelperDelegate
    
    func tableView(_ tableView: UITableView!, adCellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        // 広告行を除いたindexPathに変換し、該当行に表示させるFeedを取得する
        let originalIndexPath = self.helper.originalIndexPath(forActualIndexPath: indexPath)
        var cell: UITableViewCell?
        switch indexPath.row {
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "FeedWithAdCell3", for: indexPath)
            self.bindFeeds(self.items[(originalIndexPath?.row)!], intoCell: cell!)
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "FeedWithAdCell2", for: indexPath)
            self.bindFeeds(self.items[(originalIndexPath?.row)!], intoCell: cell!)
        case 6:
            cell = tableView.dequeueReusableCell(withIdentifier: "FeedAdCell", for: indexPath)
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView!, heightForAdRowAt indexPath: IndexPath!) -> CGFloat {
        // 広告行の高さを返却
        switch indexPath.row {
        case 1:
            return 160.0
        case 3:
            return 140.0
        case 6:
            return 80.0
        default:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView!, estimatedHeightForAdRowAt indexPath: IndexPath!) -> CGFloat {
        return self.tableView(tableView, heightForAdRowAt: indexPath)
    }

    // MARK: - Private
    
    fileprivate func createDateSource( _ feeds: [Feed]) -> [[Feed]]! {
        let fix = [4, 3, 1, 2]
        let loop = [3, 1, 1, 3, 2]
        var result = [[Feed]]()
        var index = 0
        var work = fix
        var workFeeds = feeds
        
        while true {
            if index >= work.count {
                index = 0
            }
            let size = work[index]
            if workFeeds.count >= size {
                var array = [Feed]()
                for _ in 0..<size {
                    array.append(workFeeds.removeFirst())
                }
                result.append(array)
            } else {
                break
            }
            if feeds.isEmpty {
                break
            }
            index += 1
            if work == fix && index == fix.count {
                work = loop
                index = 0
            }
        }
                
        return result
    }
    
    fileprivate func bindFeeds(_ feeds: [Feed]!, intoCell cell: UITableViewCell) {
        for i in 0..<feeds.count {
            let feed = feeds[i]
            let feedView = cell.viewWithTag(i + 1) as? FeedView
            if feed.isAd {
                if let view = feedView {
                    view.adLoading = true
                }
                continue
            } else {
                if let view = feedView {
                    view.adLoading = false
                    view.titleText = feed.title
                    view.categoryText = feed.category
                    view.link = feed.link
                }
            }
        }
    }
}
