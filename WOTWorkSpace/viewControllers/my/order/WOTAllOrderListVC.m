//
//  WOTAllOrderListVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTAllOrderListVC.h"
#import "WOTOrderLIstBaseVC.h"
#import "header.h"
@interface WOTAllOrderListVC ()

@end

@implementation WOTAllOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavi];
    [self configNaviItem];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setpageMenu{
    
 
    [self makeVC];
    
    //支持网易云音乐，今日头条，微博等切换栏效果
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:self.childViewControllers childTitles:@[@"工位订单", @"会议室订单"]];
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
    self.pageTabView.maxNumberOfPageItems = 2;
    
    //    self.pageTabView.tabItemFont = [UIFont systemFontOfSize:18];
    
    //    self.pageTabView.indicatorHeight = 5;
    self.pageTabView.indicatorWidth = 20;
    //    self.pageTabView.tabBackgroundColor = [UIColor yellowColor];
    //    self.pageTabView.unSelectedColor = [UIColor greenColor];
    
    //    self.pageTabView.tabSize = CGSizeMake(self.view.bounds.size.width-30, 0);
    [self.view addSubview:self.pageTabView];
}


- (UIViewController *)makeVC {
    
     WOTOrderLIstBaseVC *vc1 = [[WOTOrderLIstBaseVC alloc]init];
    
    vc1.orderlisttype = WOTPageMenuVCTypeStation;
   
    WOTOrderLIstBaseVC *vc2 = [[WOTOrderLIstBaseVC alloc]init];
    
    vc2.orderlisttype = WOTPageMenuVCTypeMetting;
    
    
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    
  
    
    return vc1;
}

-(void)configNavi{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的订单";
    
}

-(void)configNaviItem{
    UIButton *settingbtn = [[UIButton alloc]init];
    [settingbtn setFrame:CGRectMake(0,0,25,25)];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [settingbtn addTarget:self action:@selector(popToSearchVC) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:settingbtn];
    
}

-(void)popToSearchVC{

    WOTSearchVC *searchvc = [[WOTSearchVC alloc]init];
    [self.navigationController pushViewController:searchvc animated:YES];
};

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
