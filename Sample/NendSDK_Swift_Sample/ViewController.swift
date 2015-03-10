//
//  ViewController.swift
//  NendSDK_Swift_Sample
//
//  Created by ADN on 2014/10/03.
//  Copyright (c) 2014年 F@N Communications. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var titles = [
        "320x50",
        "320x100",
        "300x100",
        "300x250",
        "728x90",
        "Icon",
        "Interstitial"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "NendSwiftSample"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel!.text = titles[indexPath.row]
        return cell
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row{
        case 0:
            let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("BannerView320x50Controller") as BannerView320x50Controller
            viewController.title = "320x50"
            self.navigationController!.pushViewController(viewController, animated: true)
            
        case 1:
            let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("BannerView320x100Controller") as BannerView320x100Controller
            viewController.title = "320x100"
            self.navigationController!.pushViewController(viewController, animated: true)
            
        case 2:
            let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("BannerView300x100Controller") as BannerView300x100Controller
            viewController.title = "300x100"
            self.navigationController!.pushViewController(viewController, animated: true)
            
        case 3:
            let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("BannerView300x250Controller") as BannerView300x250Controller
            viewController.title = "300x250"
            self.navigationController!.pushViewController(viewController, animated: true)
            
        case 4:
            let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("BannerView728x90Controller") as BannerView728x90Controller
            viewController.title = "728x90"
            self.navigationController!.pushViewController(viewController, animated: true)
            
        case 5:
            let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("IconViewController") as IconViewController
            viewController.title = "Icon"
            self.navigationController!.pushViewController(viewController, animated: true)
            
        case 6:
            let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("InterstitialViewController") as InterstitialViewController
            viewController.title = "Interstitial"
            self.navigationController!.pushViewController(viewController, animated: true)
            
        default:
            break
        }
    }


}

