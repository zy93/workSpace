//
//  WOTSocialcontact.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSocialcontact.h"
#import "WOTNearCirclesVC.h"
@interface WOTSocialcontact ()

@end

@implementation WOTSocialcontact

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

}
-(void)configNavi{
    self.navigationItem.title = @"易创客";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]init]];
}



-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"最近的圈子",@"友邻企业",@"空间集市",nil];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    WOTNearCirclesVC *circle = [[UIStoryboard storyboardWithName:@"Socialcontact" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTNearCirclesVCID"];

    [self addChildViewController:circle];
    WOTNearCirclesVC *circle1 = [[UIStoryboard storyboardWithName:@"Socialcontact" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTNearCirclesVCID"];
    WOTNearCirclesVC *circle2 = [[UIStoryboard storyboardWithName:@"Socialcontact" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTNearCirclesVCID"];
    
    [self addChildViewController:circle1];
    
    [self addChildViewController:circle2];
    
    
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
