//
//  YLGTabBarController.m
//  YLGCommerceSpace
//
//  Created by 张姝枫 on 2017/6/26.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "YLGTabBarController.h"
#import "header.h"
@interface YLGTabBarController ()

@end

@implementation YLGTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"测试");
    self.view.backgroundColor = [UIColor redColor];
    [MBProgressHUDUtil showMessage:@"网络错误" toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
