//
//  WOTTabBarVCViewController.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTTabBarVCViewController.h"

@interface WOTTabBarVCViewController ()

@end

@implementation WOTTabBarVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubControllers];
    [self configTab];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSubControllers{
    NSMutableArray *vcarray = [[NSMutableArray alloc]init];
    
    WOTMainVC *mainvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTMainVCID"];
    WOTMainNavigationController *mainnav = [[WOTMainNavigationController alloc]initWithRootViewController:mainvc];
    mainvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"main"] selectedImage:[UIImage imageNamed:@"main_select"]];
   
   
    
    WOTSocialcontact *socialvc = [[UIStoryboard storyboardWithName:@"Socialcontact" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSocialcontactID"];
    socialvc.navigationItem.title = @"众创空间移动客户端";
    
    WOTSocialcontactNaviController *socialnav = [[WOTSocialcontactNaviController alloc]initWithRootViewController:socialvc];
    socialnav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"社交" image:[UIImage imageNamed:@"socialcontact"] selectedImage:[UIImage imageNamed:@"socialcontact_select"]];
    
    WOTServiceVC *servicevc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTServiceVC"];
    servicevc.navigationItem.title = @"众创空间移动客户端";
    WOTServiceNaviController *servicnav = [[WOTServiceNaviController alloc]initWithRootViewController:servicevc];
    servicnav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"服务" image:[UIImage imageNamed:@"service"] selectedImage:[UIImage imageNamed:@"service_select"]];
    
    WOTMyNaviController *myvc = [[WOTMyNaviController alloc]initWithRootViewController:[[WOTMyVC alloc]init]];
    myvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"my"] selectedImage:[UIImage imageNamed:@"my_select"]];
    
    
   
    [vcarray addObject:mainnav];
    [vcarray addObject:socialnav];
    [vcarray addObject:servicnav];
    [vcarray addObject:myvc];
    self.viewControllers = vcarray;
}
-(void)configTab{
   
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"fgcolor"]];
    self.tabBar.translucent = NO;
 
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
