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
#import "WOTDatePickerView.h"
#import "WOTSelectWorkspaceListVC.h"//1
#import "WOTOrderVC.h"
#import "WOTSpaceModel.h"
#import "WOTBookStationListModel.h"
#import "WOTMenuView.h"

@interface WOTBookStationVC ()<UITableViewDelegate,UITableViewDataSource, WOTBookStationCellDelegate>
{
    NSArray *allModelList; //所有的
    NSArray *tableList;
    NSString *cityName;
    NSString *inquireTime;//查询日期;
}

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
@property(nonatomic,strong)WOTDatePickerView *datepickerview;
@property (weak, nonatomic) IBOutlet UIImageView *notInformationImageView;
@property (weak, nonatomic) IBOutlet UILabel *notBookStationInformationLabel;
@property (nonatomic, strong)WOTMenuView *menuView;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong)UIBarButtonItem *barButton;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat height;


//@property (nonatomic,strong) NSString *spaceNme;

@end

@implementation WOTBookStationVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupView];
    //_spaceId = @(56);原来
    inquireTime = [NSDate getNewTimeZero];
    cityName = [WOTSingtleton shared].cityName;
    
//    WOTLocationModel *model = [WOTSingtleton shared].nearbySpace;
//    NSLog(@"最近空间%@",model.spaceName);
//    _spaceId = model.spaceId;
    if (!cityName) {
        cityName = @"未定位";
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
//    [self configNaviBackItem];
    //[self createRequest];
    self.menuArray = [[NSMutableArray alloc] init];
    [self configNavi];
    
}

-(void)configNavi{
    self.navigationItem.title = @"订工位";
    ///需要更改的地方spaceName
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(selectSpace:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:cityName forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *imageForButton = [UIImage imageNamed:@"Triangular"];
    [button setImage:imageForButton forState:UIControlStateNormal];
    CGSize buttonTitleLabelSize = [cityName sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}]; //文本尺寸
    CGSize buttonImageSize = imageForButton.size;   //图片尺寸
    button.frame = CGRectMake(0,0,
                              buttonImageSize.width + buttonTitleLabelSize.width,
                              buttonImageSize.height);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width - button.frame.size.width + button.titleLabel.intrinsicContentSize.width, 0, 0);

    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -button.titleLabel.frame.size.width - button.frame.size.width + button.imageView.frame.size.width);

    self.barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = self.barButton;
    CGRect frameInNaviView = [self.navigationController.view convertRect:button.frame fromView:button.superview];
    self.y = frameInNaviView.origin.y;
    self.height = frameInNaviView.size.height;
    //解决布局空白问题--dong
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    self.navigationController.navigationBar.translucent = NO; //有个万恶的黑色

}

-(void)setupView
{
    self.viewWidth.constant = self.view.frame.size.width/3;
    self.view.backgroundColor = MainColor;
    self.tableIView.backgroundColor = CLEARCOLOR;
    [self setTextColor:UIColorFromRGB(0x5484e7) tomorrowcolor:[UIColor blackColor] timecolor:[UIColor blackColor]];
    
    __weak typeof(self) weakSelf = self;

    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height - 250, self.view.frame.size.width, 250)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day,NSInteger hour,NSInteger min){
        weakSelf.datepickerview.hidden = YES;
        NSLog(@"%ld年%ld月%ld日",year,month,day);
        inquireTime = [NSString stringWithFormat:@"%02d/%02d/%02d %02d:%02d",(int)year, (int)month, (int)day,(int)hour,(int)min];
    };
    
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden  = YES;
}

#pragma mark - request
-(void)createRequest
{
    //待讨论根据sapceid获取所有的工位
    /*
    [WOTHTTPNetwork getSpaceSitationBlock:^(id bean, NSError *error) {
        WOTBookStationListModel_msg *msg = bean;
        allModelList = msg.msg;
        //self.spaceName = allModelList
        for (WOTBookStationListModel_msg_List *model in allModelList) {
            if ([model.cityName isEqualToString:cityName]) {
                tableList = model.cityList;
                
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (tableList) {
                [self.tableIView reloadData];
            } else {
                NSLog(@"没有数据");
            }
        });
    }];
     */
//    [WOTHTTPNetwork getBookStationWithSpaceId:_spaceId response:^(id bean, NSError *error) {
//        if (error) {
//            NSLog(@"error:%@",error);
//            return ;
//        }
//        WOTBookStationListModel_msg *msg = bean;
//        tableList = msg.msg;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (tableList.count) {
//                self.notInformationImageView.hidden = YES;
//                self.notBookStationInformationLabel.hidden = YES;
//                [self.tableIView  reloadData];
//            } else {
//                self.notInformationImageView.hidden = NO;
//                self.notBookStationInformationLabel.hidden = NO;
//                NSLog(@"没有数据");
//            }
//        });
//
//    }];
    [WOTHTTPNetwork getAllSpaceWithCity:cityName block:^(id bean, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error);
            return ;
        }
        WOTSpaceModel_msg *list = bean;
        NSLog(@"测试%@",list.msg);
        //        tableList = list.msg;
        //tableDic = [self sortByCity:list.msg];
        tableList = list.msg;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableIView  reloadData];
        });
    }];
}


#pragma mark - action

- (IBAction)selectedToday:(id)sender {
    self.indicatorVIewCenter.constant = self.todayView.frame.origin.x;
    [self setTextColor:UIColorFromRGB(0x5484e7) tomorrowcolor:[UIColor blackColor] timecolor:[UIColor blackColor]];
    inquireTime = [NSDate getNewTimeZero];
    _datepickerview.hidden = YES;
}

- (IBAction)selectedTomorrow:(id)sender {
    self.indicatorVIewCenter.constant = self.tomorrowView.frame.origin.x;
     [self setTextColor:[UIColor blackColor] tomorrowcolor:UIColorFromRGB(0x5484e7) timecolor:[UIColor blackColor]];
    inquireTime = [NSDate getTomorrowTimeZero];
    _datepickerview.hidden = YES;
}

- (IBAction)selectedTime:(id)sender {
    self.indicatorVIewCenter.constant = self.selectDateView.frame.origin.x;
    [self setTextColor:[UIColor blackColor] tomorrowcolor:[UIColor blackColor] timecolor:UIColorFromRGB(0x5484e7)];
    _datepickerview.hidden = NO;
}


-(void)selectSpace:(UIButton *)sender
{
    [self.menuView menuTappedWithSuperView:self.barButton];
    [self.menuView reloadData];
//    WOTSelectWorkspaceListVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSelectWorkspaceListVC"];//1
//    __weak typeof(self) weakSelf = self;
//    vc.selectSpaceBlock = ^(NSNumber *spaceId, NSString *spaceName){
//        weakSelf.spaceId = spaceId;
//        weakSelf.spaceName = spaceName;
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}

- (WOTMenuView *)menuView {
    if (!_menuView && [self.menuArray count] > 0) {
        
//        _menuView = [[WOTMenuView alloc] initWithOrigin:CGPointMake(0, self.barButton.frame.origin.y + self.barButton.frame.size.height)];
        //_menuView.transformImageView = self.tagsArrowImage;
         //_menuView = [[WOTMenuView alloc] initWithOrigin:CGPointMake(0, self.y + self.height)];
        _menuView = [[WOTMenuView alloc] initWithOrigin:CGPointMake(0, 200)];
        _menuView.titleLabel = cityName;
        
        _menuView.dataSource = self;
        _menuView.delegate = self;
    }
    return _menuView;
}

-(NSMutableArray *)menuArray {
    if (!_menuArray) {
        
        _menuArray = [NSMutableArray array];
        WOTFilterTypeModel *model = [[WOTFilterTypeModel alloc]initWithName:@"全部" andId:@"one"];
        WOTFilterTypeModel *model2 = [[WOTFilterTypeModel alloc]initWithName:@"软件服务商" andId:@"two"];
        WOTFilterTypeModel *model3 = [[WOTFilterTypeModel alloc]initWithName:@"法律" andId:@"three"];
        WOTFilterTypeModel *model4 = [[WOTFilterTypeModel alloc]initWithName:@"硬件服务商" andId:@"four"];
        WOTFilterTypeModel *model5 = [[WOTFilterTypeModel alloc]initWithName:@"其他" andId:@"five"];
        [_menuArray addObject:model];
        [_menuArray addObject:model2];
        [_menuArray addObject:model3];
        [_menuArray addObject:model4];
        [_menuArray addObject:model5];
        
    }
    
    return _menuArray;
    
//    __weak typeof(self) weakSelf = self;
//    NSMutableArray *cityList = [NSMutableArray new];
//
//    [WOTHTTPNetwork getSapaceFromGroupBlock:^(id bean, NSError *error) {
//        if (error) {
//            NSLog(@"error:%@",error);
//            return ;
//        }
//        WOTSpaceModel_msg *list = bean;
//
//
//    }];
//    return cityList;
}


-(void)createRequestCityList:(NSArray *)array
{
    NSMutableArray *cityList = [NSMutableArray new];
    
    for (WOTSpaceModel *model in array) {
        //
        BOOL isHaveCity = NO;
        for (NSString *city in cityList) {
            NSLog(@"测试1%@",city);
            NSLog(@"测试2%@",model.city);
            if ([model.city isEqualToString:city]) {
                isHaveCity = YES;
                break;
            }
        }
        if (!isHaveCity) {
            [cityList addObject:model.city];
        }
        [cityList addObject:model.city];
    }
    
}

#pragma mark -

-(void)setTextColor:(UIColor *)todaycolor tomorrowcolor:(UIColor *)tomorrowcolor timecolor:(UIColor *)timecolor{
    self.todayLabel.textColor = todaycolor;
    self.tomorrowLabel.textColor = tomorrowcolor;
    self.selectedTimeLabel.textColor = timecolor;
}

#pragma mark - cell delegate
-(void)gotoOrderVC:(WOTBookStationCell *)cell
{
    WOTOrderVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTOrderVC"];
    vc.startTime = inquireTime;//arr.firstObject;
    vc.endTime = inquireTime;//arr.lastObject;
    vc.spaceId = self.spaceId;
//    vc.conferenceId = cell.model.conferenceId;
    [WOTSingtleton shared].orderType = ORDER_TYPE_BOOKSTATION;
    vc.model = cell.model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table datasource & delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  tableList.count;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    return  225;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTBookStationCell *bookcell = [tableView dequeueReusableCellWithIdentifier:@"WOTBookStationCellID" forIndexPath:indexPath];
    if (tableList) {
        WOTBookStationListModel *model = tableList[indexPath.row];
        //待开发
//        bookcell.spaceName.text =model.spaceName;// @"方圆大厦-众创空间";
//        bookcell.spaceLocation.text = model.spaceSite;// @"中关村南大街甲56号" ;
//        bookcell.stationNum.text  = [NSString stringWithFormat:@"%ld工位可以预定",model.longRent.integerValue+model.shortRent.integerValue]; //@"23个工位可以预定";
//        bookcell.stationPrice.text = [NSString stringWithFormat:@"￥%ld/天",model.spacePicture.integerValue];//@"¥123元／天";
        bookcell.delegate = self;
        bookcell.model = model;
    } else {
        NSLog(@"测试：没有数据！");
        
    }
   
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
