//
//  WOTMyActivitiesVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyActivitiesVC.h"
#import "WOTMyActivitiesBaseVC.h"
@interface WOTMyActivitiesVC ()

@end

@implementation WOTMyActivitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    [self configNavi];
    // Do any additional setup after loading the view.
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
    self.navigationItem.title = @"我的活动";
}



-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"全部",@"待支付",@"待使用",@"已完成",@"已取消", nil];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    WOTMyActivitiesBaseVC *basevc = [[WOTMyActivitiesBaseVC alloc]init];

    [self addChildViewController:basevc];
    WOTMyActivitiesBaseVC *basevc1 = [[WOTMyActivitiesBaseVC alloc]init];

    [self addChildViewController:basevc1];
    WOTMyActivitiesBaseVC *basevc2 = [[WOTMyActivitiesBaseVC alloc]init];
  
    [self addChildViewController:basevc2];
    WOTMyActivitiesBaseVC *basevc3 = [[WOTMyActivitiesBaseVC alloc]init];

    [self addChildViewController:basevc3];
    WOTMyActivitiesBaseVC *basevc4 = [[WOTMyActivitiesBaseVC alloc]init];
 
    [self addChildViewController:basevc4];
    
    return self.childViewControllers;
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
