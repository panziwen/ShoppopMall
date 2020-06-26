//
//  TabBarController.swift
//  ShoppopMall
//
//  Created by 潘子文 on 2020/6/27.
//  Copyright © 2020 潘子文. All rights reserved.
//

import UIKit

//定义一个变量，控制如何跳转
var change: Bool = true

class TabBarController: UITabBarController , UITabBarControllerDelegate {

deinit {
    print("MainTabBarController销毁")
}
//MARK: --life cyle
override func viewDidLoad() {
    super.viewDidLoad()
    
    // 添加跳转到首页的观察者
    NotificationCenter.default.addObserver(self, selector: #selector(pushHome), name: NSNotification.Name(rawValue: "pushLogin"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(pushCollection), name: NSNotification.Name(rawValue: "pushCollection"), object: nil)
    
    self.tabBarController?.hidesBottomBarWhenPushed = true
    initBaseLayout()
    
    self.delegate = self
    
}

//MARK: - prinvate methods
//添加视图
func initBaseLayout(){
    //主页
    let homeVC = MallTableViewController()
    let homeNav = UINavigationController(rootViewController: homeVC)
    let image1 = UIImage(named: "tabbaritem_home_normal")?.withRenderingMode(.alwaysOriginal)
    let image1_s = UIImage(named: "tabbaritem_home_select")?.withRenderingMode(.alwaysOriginal)
    let item1:UITabBarItem = UITabBarItem(title: "首页", image: image1, selectedImage: image1_s)
    item1.tag = 0
    homeNav.tabBarItem = item1
    
    //我的
    let mineVC = MyTableViewController()
    let mineNav = UINavigationController(rootViewController: mineVC)
    let image4 = UIImage(named: "tabbaritem_mine_normal")?.withRenderingMode(.alwaysOriginal)
    let image4_s = UIImage(named: "tabbaritem_mine_select")?.withRenderingMode(.alwaysOriginal)
    let item4:UITabBarItem = UITabBarItem(title: "我的", image: image4, selectedImage: image4_s)
    item4.tag = 1
    mineNav.tabBarItem = item4
    
    let tabArray = [homeNav,mineNav]
    self.viewControllers = tabArray
    
}
//跳转到首页
    @objc func pushHome(){
    self.selectedIndex = 0
}
//跳转到收藏
    @objc func pushCollection() {
    self.selectedIndex = 1
}

//MARK: --setter getter
var _lastSelectedIndex: NSInteger!
var lastSelectedIndex: NSInteger {
    if _lastSelectedIndex == nil {
        _lastSelectedIndex = NSInteger()
        //判断是否相等,不同才设置
        if (self.selectedIndex != selectedIndex) {
            //设置最近一次
            _lastSelectedIndex = self.selectedIndex;
        }
        //调用父类的setSelectedIndex
        super.selectedIndex = selectedIndex
    }
    return _lastSelectedIndex
}


override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    //获取选中的item
    let tabIndex = tabBar.items?.index(of: item)
    if tabIndex != self.selectedIndex {
        //设置最近一次变更
        _lastSelectedIndex = self.selectedIndex
    }
}

//MARK: -- UITabBarControllerDelegate
func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if viewController == self.viewControllers![1]  {
        if change {
            
            self.selectedIndex = _lastSelectedIndex
            let login = LoginViewController()
            login.tag = 2
            let nav = UINavigationController(rootViewController: login)
            self.viewControllers![selectedIndex].present(nav, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    return true
  }
    
}
