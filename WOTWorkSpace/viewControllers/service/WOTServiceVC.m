//
//  WOTServiceVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTServiceVC.h"
#import "WOTRegisterServiceProvidersVC.h"
#import "WOTServiceProvidersApplyCell.h"
#import "WOTGETServiceCell.h"

@interface WOTServiceVC () <UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>
{
    NSMutableArray *tableList;

}

@property (weak, nonatomic) IBOutlet SDCycleScrollView *autoScrollView;
@property (weak, nonatomic) IBOutlet UITableView *table;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollviewHeight;


@end

@implementation WOTServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self loadAutoScrollView];
    [self addData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)configNav{
    self.navigationItem.title = @"服务";
    
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)addData
{
    NSArray *section1 = @[@"申请成为平台服务商", @"投融资"];
    NSArray *section2 = @[@"访客预约", @"问题报修", @"一键开门", @"发布需求", @"意见反馈"];
    NSArray *section3 = @[@"灯光", @"空调"];
    tableList = [@[section1, section2, section3] mutableCopy];
    
    [self.table reloadData];
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

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    self.scrollviewHeight.constant = CGRectGetHeight(self.autoScrollView.frame)+self.tableView.contentSize.height;
}

#pragma mark  - action
-(void)pushVCByVCName:(NSString *)vcName
{
    WOTRegisterServiceProvidersVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:vcName];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - SDCycleScroll delgate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

#pragma mark - Table delegate & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArr = tableList[section];
    return sectionArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        if ( indexPath.row==0) {
            return 45;
        }
        return 105;
    }
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0? 0:10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==1) {
        WOTGETServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTGETServiceCell"];
        if (cell == nil) {
            cell = [[WOTGETServiceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTGETServiceCell"];
        }
//        NSArray *sectionArr = tableList[indexPath.section];
//        
//        [cell.titleLab setText:sectionArr[indexPath.row]];

        return cell;

    }
    else {
        WOTServiceProvidersApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTServiceProvidersApplyCell"];
        if (cell == nil) {
            cell = [[WOTServiceProvidersApplyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTServiceProvidersApplyCell"];
        }
        NSArray *sectionArr = tableList[indexPath.section];
        
        [cell.titleLab setText:sectionArr[indexPath.row]];
        return cell;

    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            [self pushVCByVCName:@"WOTRegisterServiceProvidersVC"];
        }
        else if (indexPath.row==1) {
            [self pushVCByVCName:@"WOTGETServiceViewController"];
        }
    }
    else if (indexPath.section==1) {
        if (indexPath.row==0) {
            [self pushVCByVCName:@"WOTVisitorsAppointmentVC"];
        }
        else if (indexPath.row==1) {
            [self pushVCByVCName:@"WOTMaintenanceApplyVC"];
        }
        else if (indexPath.row==2) {
//            [self pushVCByVCName:@""];
        }
        else if (indexPath.row==3) {
            [self pushVCByVCName:@"WOTGETServiceViewController"];
        }
        else if (indexPath.row==4) {
            [self pushVCByVCName:@"WOTFeedbackVC"];
        }
    }
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
