//
//  WOTOrderLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTOrderLIstVC.h"
#import "header.h"

@interface WOTOrderLIstVC ()



@end

@implementation WOTOrderLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];
      [self configNavi];
   
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)configNavi{
    [self configNaviBackItem];
   
    if (self.vctype == WOTPageMenuVCTypeMetting) {
            self.navigationItem.title = @"会议室订单";
    } else if (self.vctype == WOTPageMenuVCTypeStation){
        self.navigationItem.title = @"工位订单";
    }

}


-(void)setpageMenu{
    UIViewController *test1 = [self makeVC];
    UIViewController *test2 = [self makeVC];
    UIViewController *test3 = [self makeVC];
    UIViewController *test4 = [self makeVC];
    UIViewController *test5 = [self makeVC];
    
    
    [self addChildViewController:test1];
    [self addChildViewController:test2];
    [self addChildViewController:test3];
    [self addChildViewController:test4];
    [self addChildViewController:test5];
    
    
    //支持网易云音乐，今日头条，微博等切换栏效果
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:self.childViewControllers childTitles:@[@"全部", @"待支付", @"待使用", @"已完成", @"已取消"]];
    self.pageTabView.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    self.pageTabView.delegate = self;
    //    self.pageTabView.bodyBounces = NO;
    //    self.pageTabView.tabSize = CGSizeMake(self.view.frame.size.width, 40);
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    //    self.pageTabView.minScale = 1.0;
    //    self.pageTabView.selectedTabIndex = 4;
    //    self.pageTabView.selectedTabIndex = -1;
    //    self.pageTabView.selectedTabIndex = 4;
    
    //    self.pageTabView.maxNumberOfPageItems = 1;
    self.pageTabView.maxNumberOfPageItems = 5;
    
    //    self.pageTabView.tabItemFont = [UIFont systemFontOfSize:18];
    
    //    self.pageTabView.indicatorHeight = 5;
    self.pageTabView.indicatorWidth = 20;
    //    self.pageTabView.tabBackgroundColor = [UIColor yellowColor];
    //    self.pageTabView.unSelectedColor = [UIColor greenColor];
    
    //    self.pageTabView.tabSize = CGSizeMake(self.view.bounds.size.width-30, 0);
    [self.view addSubview:self.pageTabView];
}



- (UIViewController *)makeVC {

    WOTOrderLIstBaseVC *basevc = [[WOTOrderLIstBaseVC alloc]init];
    basevc.orderlisttype = self.vctype;
    
    return basevc;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
