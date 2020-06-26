//
//  SonicpMallTableViewController.swift
//  SonicpMall
//
//  Created by 潘子文 on 2020/6/5.
//  Copyright © 2020 潘子文. All rights reserved.
//

import UIKit

class MallTableViewController: UITableViewController {

    var SonicpMalls = [Feed]()
    
    @IBOutlet weak var tb: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        getTabBar()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "ShoppopMall"
        //開始下拉更新的功能
        refreshControl = UIRefreshControl()
        //修改顯示文字的顏色
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
        //顯示文字內容
        refreshControl?.attributedTitle = NSAttributedString(string: "正在更新", attributes: attributes)
        //設定元件顏色
        refreshControl?.tintColor = UIColor.white
        //設定背景顏色
        refreshControl?.backgroundColor = UIColor.black
        //將元件加入TableView的視圖中
        refreshControl?.addTarget(self, action: #selector(getData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl

        
        MallClient.shared.getDecard(urlString: "https://www.sonicp.cn/API/Product/") { (SonicpMalls) in
            if let SonicpMalls = SonicpMalls {
                self.SonicpMalls = SonicpMalls
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        print(SonicpMalls.count)
        return SonicpMalls.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SonicpMallCell", for: indexPath) as! MallTableViewCell
        let SonicpMall = SonicpMalls[indexPath.row]
        // Configure the cell...
        cell.titalLabel.text = "$\(SonicpMall.price)"
        cell.userTitalLabel.text = "\(SonicpMall.proname) | \(SonicpMall.brand)"
        
        cell.likeLabel.text = "\(SonicpMall.proname)"
        cell.commentLabel.text = "\(SonicpMall.pronub)"
        cell.excerptLabel.text = SonicpMall.proid
        
        if !SonicpMall.proid.isEmpty {
            MallClient.shared.getImage(urlStr: SonicpMall.photo) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    cell.excerptImageView.isHidden = false
                    cell.excerptImageView.image = image
                }
            }
        }
        
        }else{
            cell.excerptImageView.isHidden = true
        }
        return cell
    }
    
    @objc func getData() -> () {
        MallClient.shared.getDecard(urlString:
            "https://www.sonicp.cn/API/Product/"
//            "https://www.sonicp.cn/API/Product/"
        ) { (SonicpMalls) in
            if let SonicpMalls = SonicpMalls {
                self.SonicpMalls = SonicpMalls
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl!.endRefreshing()

            }
        }
    }
    
    @IBSegueAction func showDetial(_ coder: NSCoder) -> MallDetialTableViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            let controller = MallDetialTableViewController(coder: coder)
            controller?.feed = SonicpMalls[row]
            return controller
        }else{
        return nil
        }
    }
    func getTabBar(){
        let vc1 = MallTableViewController()
        let nav1 = UINavigationController(rootViewController: vc1)
        nav1.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "dongTai"), selectedImage: UIImage(named: "dongTai_H"))

        let vc2 = MyTableViewController()
        let nav2 = UINavigationController(rootViewController: vc2)
        nav2.tabBarItem = UITabBarItem(title: "返现", image: UIImage(named: "dongTai"), selectedImage: UIImage(named: "dongTai_H"))
        
        tb.items?.append(nav1.tabBarItem)
        tb.items?.append(nav2.tabBarItem)
        
    }
    
     @IBAction func tabBar(_ tabBar: UITabBar){
        for index in tabBar.items!.indices{
            if index==0{
                print(1)
            }else{
                print(2)
            }
        }
    }
}
