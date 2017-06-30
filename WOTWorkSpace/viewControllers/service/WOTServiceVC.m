//
//  WOTServiceVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTServiceVC.h"

@interface WOTServiceVC () <SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *autoScrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WOTServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configNav{
    self.navigationItem.title = @"众创空间移动客户端";
}

#pragma mark - setup View
-(void)loadAutoScrollView{
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 图片配文字
    NSArray *titles = @[@"物联港科技",
                        @"物联港科技",
                        @"物联港科技",
                        @"物联港科技"
                        ];
    
    
    self.autoScrollView.imageURLStringsGroup = imagesURLStrings;
    self.autoScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.autoScrollView.delegate = self;
    self.autoScrollView.titlesGroup = titles;
    self.autoScrollView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    self.autoScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
}


#pragma mark - SDCycleScroll delgate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
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
