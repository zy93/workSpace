//
//  WOTOrderLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTOrderLIstVC.h"
#import "header.h"
@interface WOTOrderLIstVC ()<DFSegmentViewDelegate>

@end

@implementation WOTOrderLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.pagemenuAarray = @[@"全部",@"待支付",@"待使用",@"已完成",@"已取消"];
    self.segment.delegate = self;
    [self configNavi];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)configNavi{
    [self configNaviBackItem];
    if (_vctype == WOTPageMenuVCTypeMetting) {
            self.navigationItem.title = @"会议室订单";
    } else if (_vctype == WOTPageMenuVCTypeStation){
        self.navigationItem.title = @"工位订单";
    }

}

- (UIViewController *)subViewControllerWithIndex:(NSInteger)index {
    
    
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
