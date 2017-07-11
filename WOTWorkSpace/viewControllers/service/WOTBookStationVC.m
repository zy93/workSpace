//
//  WOTBookStationVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTBookStationVC.h"
#import "XXPageTabView.h"
#import "XXPageTabItemLable.h"
#import "WOTBookStationCell.h"
@interface WOTBookStationVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) XXPageTabView *pageTabView;

@property (weak, nonatomic) IBOutlet UIView *tomorrowView;
@property (weak, nonatomic) IBOutlet UIView *todayView;
@property (weak, nonatomic) IBOutlet UIView *selectDateView;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorVIewCenter;

@property (weak, nonatomic) IBOutlet UILabel *todayLabel;

@property (weak, nonatomic) IBOutlet UILabel *tomorrowLabel;

@property (weak, nonatomic) IBOutlet UILabel *selectedTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *tomorrowBtn;

@property (weak, nonatomic) IBOutlet UIButton *todayBtn;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableIView;


@end

@implementation WOTBookStationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewWidth.constant = self.view.frame.size.width/3;
    self.view.backgroundColor = MainColor;
    self.tableIView.backgroundColor = CLEARCOLOR;
       [self setTextColor:UIColorFromRGB(0x5484e7) tomorrowcolor:[UIColor blackColor] timecolor:[UIColor blackColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"订工位";
    
}



- (IBAction)selectedToday:(id)sender {
    
    self.indicatorVIewCenter.constant = self.todayView.frame.origin.x;
    [self setTextColor:UIColorFromRGB(0x5484e7) tomorrowcolor:[UIColor blackColor] timecolor:[UIColor blackColor]];
    
}




- (IBAction)selectedTomorrow:(id)sender {
    self.indicatorVIewCenter.constant = self.tomorrowView.frame.origin.x;
     [self setTextColor:[UIColor blackColor] tomorrowcolor:UIColorFromRGB(0x5484e7) timecolor:[UIColor blackColor]];
}



- (IBAction)selectedTime:(id)sender {
    self.indicatorVIewCenter.constant = self.selectDateView.frame.origin.x;
    [self setTextColor:[UIColor blackColor] tomorrowcolor:[UIColor blackColor] timecolor:UIColorFromRGB(0x5484e7)];
    
}

-(void)setTextColor:(UIColor *)todaycolor tomorrowcolor:(UIColor *)tomorrowcolor timecolor:(UIColor *)timecolor{
    self.todayLabel.textColor = todaycolor;
    self.tomorrowLabel.textColor = tomorrowcolor;
    self.selectedTimeLabel.textColor = timecolor;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return  225;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTBookStationCell *bookcell = [tableView dequeueReusableCellWithIdentifier:@"WOTBookStationCellID" forIndexPath:indexPath];
    bookcell.spaceName.text = @"方圆大厦-众创空间";
    bookcell.spaceLocation.text = @"中关村南大街甲56号" ;
    bookcell.stationNum.text  = @"23个工位可以预定";
    bookcell.stationPrice.text = @"¥123元／天";
    return bookcell;
}




//- (UIViewController *)makeVC {
//    UIViewController *basevc = [[UIViewController alloc]init];
//    
//    
//    return basevc;
//}
//
//-(void)setpageMenu{
//    
//    UIViewController *vc1 = [[UIViewController alloc]init];
//    UIViewController *vc2 = [[UIViewController alloc]init];
//   
//    NSArray<__kindof UIViewController *> *controllers = @[vc1,vc2,vc2];
//    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:controllers childTitles:@[@"今日",@"明日",@"选择日期"]];
//    self.pageTabView.cutOffLine = NO;
//    [self.pageTabView layoutSubviews];
//    self.pageTabView.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
//    self.pageTabView.delegate = self;
//    self.pageTabView.tabSize = CGSizeMake(self.view.frame.size.width, 40);
//    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
//    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
//    self.pageTabView.maxNumberOfPageItems = 5;
//    self.pageTabView.indicatorWidth = 20;
// 
//    [self.view addSubview:self.pageTabView];
//}
//
//#pragma mark - XXPageTabViewDelegate
//- (void)pageTabViewDidEndChange {
//    NSLog(@"#####%d", (int)self.pageTabView.selectedTabIndex);
//    if (self.pageTabView.selectedTabIndex == 2) {
//        NSLog(@"显示选择时间");
//    }
//}
//
//#pragma mark - Event response
//- (void)scrollToLast:(id)sender {
//    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex-1];
//}
//
//- (void)scrollToNext:(id)sender {
//    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex+1];
//}
//
//- (void)refreshPageTabView:(id)sender {
//    //移除原有子控制器
//    for(UIViewController *vc in self.childViewControllers) {
//        [vc removeFromParentViewController];
//    }
//    
//    UIViewController *test1 = [self makeVC];
//    UIViewController *test2 = [self makeVC];
//    UIViewController *test3 = [self makeVC];
//    UIViewController *test4 = [self makeVC];
//    UIViewController *test5 = [self makeVC];
//    
//    [self addChildViewController:test1];
//    [self addChildViewController:test2];
//    [self addChildViewController:test3];
//    [self addChildViewController:test4];
//    [self addChildViewController:test5];
//    
//    [self.pageTabView reloadChildControllers:self.childViewControllers childTitles:@[@"全部", @"待支付", @"待使用", @"已完成", @"已取消"]];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
