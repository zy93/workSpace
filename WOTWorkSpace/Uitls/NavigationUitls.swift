//
//  NavigationUitls.swift
//  MediaProduct
//
//  Created by 张姝枫 on 2017/6/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

import UIKit
extension UIViewController{
    
    //配置返回按钮
    func configBackItem(){
        let backitem = UIBarButtonItem(image:UIImage.init(named: "back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.goback))
        self.navigationItem.backBarButtonItem?.setBackButtonBackgroundImage(UIImage.init(named: "back"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backitem
  
    }

    //配置导航title
    func configNaviTitle(_ tintcolor:UIColor,font:CGFloat,title:String){
        
        //定义标题颜色与字体大小字典
        let dict:NSDictionary = [NSForegroundColorAttributeName: White,NSFontAttributeName : UIFont.boldSystemFont(ofSize:font)]
        //标题设置颜色与字体大小
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [String : AnyObject]
        
        self.navigationItem.titleView = nil
        self.navigationItem.title = title
        
    }
    

    //配置导航搜索view
    func configNaviSearchView(searchTitle:String,complete:@escaping ()->Void){
        let searchView = UISearchBar(frame: CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.width)!, height: 30))
        searchView.placeholder = searchTitle
        complete()
        self.navigationItem.titleView = searchView
        
    }
    func goback()->Void{
        self.navigationController?.popViewController(animated: true)
    }
   }
