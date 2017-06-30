//
//  UIViewController+Extension.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController(Extension)
-(void)configNaviBackItem{
    
    UIBarButtonItem *backitem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    
    [self.navigationItem.backBarButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setLeftBarButtonItem:backitem];
    [self.tabBarController.tabBar setHidden:YES];
}


-(void)configNaviView:(NSString *)searchTitle block:(void(^)())search{
    UISearchBar *searchview = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 30.0)];
    [searchview setPlaceholder:searchTitle];
    search();
    [self.navigationItem setTitleView:searchview];
    
}

-(void)goback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
