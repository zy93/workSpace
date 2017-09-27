//
//  WOTReservationsMeetingVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTReservationsMeetingVC.h"
#import "WOTReservationsMeetingCell.h"
#import "WOTOrderVC.h"
#import "WOTSelectWorkspaceListVC.h"//1
#import "WOTDatePickerView.h"
#import "WOTMeetingListModel.h"
#import "WOTMeetingReservationsModel.h"
#import "WOTSiteModel.h"
#import "MBProgressHUD+Extension.h"
#import "JudgmentTime.h"



@interface WOTReservationsMeetingVC () <UITableViewDelegate, UITableViewDataSource, WOTReservationsMeetingCellDelegate>
{
    NSArray *tableList;
    NSIndexPath *selectIndex;
//    NSMutableArray *invalidTimeList; //失效时间记录
    NSString *inquireTime;//查询日期;
    CGPoint ofoset;
    
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewCenter;
@property (weak, nonatomic) IBOutlet UIButton *tomorrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectTimeBtn;
@property (nonatomic,strong) WOTDatePickerView *datepickerview;
@property (weak, nonatomic) IBOutlet UIImageView *notInformationImageView;
@property (weak, nonatomic) IBOutlet UILabel *notInformationLabel;
@property (nonatomic, strong) JudgmentTime *judgmentTime;
@property (nonatomic, assign) BOOL isValidTime;

@property (nonatomic, assign) int year;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int day;

@end

@implementation WOTReservationsMeetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    [self.table registerNib:[UINib nibWithNibName:@"WOTReservationsMeetingCell" bundle:nil] forCellReuseIdentifier:@"WOTReservationsMeetingCell"];
    
    _spaceId = [WOTSingtleton shared].nearbySpace.spaceId ;
    inquireTime = [NSDate getNewTimeZero];
    
    WOTLocationModel *model = [WOTSingtleton shared].nearbySpace;
    NSLog(@"最近空间%@",model.spaceName);
    if (model.spaceName) {
        self.spaceName = model.spaceName;
    }
    else
    {
        self.spaceName = @"未定位";
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.judgmentTime = [[JudgmentTime alloc] init];
    [self.navigationController.navigationBar setHidden:NO];
    selectIndex = nil;
    NSLog(@"%@",self.spaceId);
    [self createRequest];
    [self configNavi];

}

-(void)configNavi
{
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
        self.navigationItem.title = @"预定会议室";
    }
    else {
        self.navigationItem.title = @"预定场地";
    }
    
    ///需要更改的地方
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(selectSpace:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:self.spaceName forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *imageForButton = [UIImage imageNamed:@"Triangular"];
    
    [button setImage:imageForButton forState:UIControlStateNormal];
    CGSize buttonTitleLabelSize = [self.spaceName sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}]; //文本尺寸
    CGSize buttonImageSize = imageForButton.size;   //图片尺寸
    button.frame = CGRectMake(0,0,
                              buttonImageSize.width + buttonTitleLabelSize.width,
                              buttonImageSize.height);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width - button.frame.size.width + button.titleLabel.intrinsicContentSize.width, 0, 0);
    
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -button.titleLabel.frame.size.width - button.frame.size.width + button.imageView.frame.size.width);
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    
//    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:self.spaceName style:UIBarButtonItemStylePlain target:self action:@selector(selectSpace:)];
//    [self.navigationItem setRightBarButtonItem:doneItem];
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    self.navigationController.navigationBar.translucent = NO; //有个万恶的黑色
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark - update view

-(void)setupView
{
    //_datepickerview.hidden  = YES;
    __weak typeof(self) weakSelf = self;
    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height - [WOTUitls GetLengthAdaptRate]*300, self.view.frame.size.width, 300)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day,NSInteger hour,NSInteger min){
        weakSelf.datepickerview.hidden = YES;
       // NSLog(@"%ld年%ld月%ld日",year,month,day);
        inquireTime = [NSString stringWithFormat:@"%02d/%02d/%02d 00:00:00",year, month, day];
        NSLog(@"测试：%@",inquireTime);
        //问题有可能出现在这里
        self.isValidTime = [self.judgmentTime judgementTimeWithYear:year month:month day:day];
        //self.isValidTime = YES;
        //[self judgementTimeWithYear:year month:month day:day];
        if (self.isValidTime) {
            _datepickerview.hidden  = YES;
            [self.selectTimeBtn setTitle:[NSString stringWithFormat:@"%ld/%ld/%ld",year, month, day] forState:UIControlStateNormal];
        }else
        {
            [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:self.view];
            _datepickerview.hidden  = NO;
        }
        [weakSelf reloadView];
    };
    
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden  = YES;
}
/*
-(void)judgementTimeWithYear:(NSInteger) year month:(NSInteger)month day:(NSInteger)day
{
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    _year = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"MM"];
    _month = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"dd"];
    _day = [[formatter stringFromDate:date] intValue];
    
    if (_year > year) {
        [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:self.view];
        _datepickerview.hidden  = NO;
        _isValidTime = NO;
        return;
    }
    if (_month > month) {
        [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:self.view];
        _datepickerview.hidden  = NO;
        _isValidTime = NO;
        return;
    }
    if (_day > day) {
        [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:self.view];
        _datepickerview.hidden  = NO;
        _isValidTime = NO;
        return;
    }
    _isValidTime = YES;
    _datepickerview.hidden  = YES;
}
*/

-(void)reloadView
{
    self.beginTime = 0;
    self.endTime = 0;
    [self createRequest];
}


#pragma mark - request
-(void)createRequest
{
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
        [WOTHTTPNetwork getMeetingRoomListWithSpaceId:self.spaceId response:^(id bean, NSError *error) {
            if (error) {
                NSLog(@"error:%@",error);
                return ;
            }
            WOTMeetingListModel_msg *model = bean;
            tableList = model.msg;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (tableList.count) {
                    self.notInformationImageView.hidden = YES;
                    self.notInformationLabel.hidden = YES;
                    [self.table reloadData];
                } else {
                    self.notInformationImageView.hidden = NO;
                    self.notInformationLabel.hidden = NO;
                    self.notInformationLabel.text = @"亲，暂时没有会议室哦！";
                    NSLog(@"没有数据");
                }
                [self.table reloadData];
            });
        }];
    }
    else {
        [WOTHTTPNetwork getSiteListWithSpaceId:self.spaceId response:^(id bean, NSError *error) {
            if (error) {
                NSLog(@"error:%@",error);
                return ;
            }
            WOTSiteModel_Msg *model = bean;
            tableList = model.msg;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (tableList.count) {
                    self.notInformationImageView.hidden = YES;
                    self.notInformationLabel.hidden = YES;
                    [self.table reloadData];
                } else {
                    self.notInformationImageView.hidden = NO;
                    self.notInformationLabel.hidden = NO;
                    self.notInformationLabel.text = @"亲，暂时没有场地哦！";
                    NSLog(@"测试：没有数据");
                }
                [self.table reloadData];
            });
        }];
    }
}


#pragma mark - action
- (IBAction)today:(id)sender {
    self.indicatorViewCenter.constant = 0;
    self.todayBtn.selected = YES;
    self.tomorrowBtn.selected = NO;
    self.selectTimeBtn.selected = NO;
    inquireTime = [NSDate getNewTimeZero];
    [self reloadView];
    _datepickerview.hidden = YES;
}
- (IBAction)tomorrow:(id)sender {
    self.indicatorViewCenter.constant = CGRectGetMidX(self.tomorrowBtn.frame)-CGRectGetMidX(self.todayBtn.frame);
    self.todayBtn.selected = NO;
    self.tomorrowBtn.selected = YES;
    self.selectTimeBtn.selected = NO;
    inquireTime = [NSDate getTomorrowTimeZero];
    [self reloadView];
    _datepickerview.hidden = YES;
}
- (IBAction)selectTime:(id)sender {
    self.indicatorViewCenter.constant = CGRectGetMidX(((UIButton *)sender).frame) -CGRectGetMidX(self.todayBtn.frame);
    self.todayBtn.selected = NO;
    self.tomorrowBtn.selected = NO;
    self.selectTimeBtn.selected = YES;
    _datepickerview.hidden = NO;
    
}

-(void)selectSpace:(UIButton *)sender
{
    WOTSelectWorkspaceListVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSelectWorkspaceListVC"];//1
    __weak typeof(self) weakSelf = self;
    vc.selectSpaceBlock = ^(NSNumber *spaceId, NSString *spaceName){
        weakSelf.spaceId = spaceId;
        weakSelf.spaceName = spaceName;
    };
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - cell delegate
-(void)submitReservationsCell:(WOTReservationsMeetingCell *)cell
{
    WOTOrderVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTOrderVC"];
    if (self.endTime == 0) {
        return;
    }
    NSArray *arr = [NSString getReservationsTimesWithDate:inquireTime StartTime:self.beginTime  endTime:self.endTime];
    vc.startTime = arr.firstObject;
    vc.endTime = arr.lastObject;
    vc.spaceId = self.spaceId;
    if([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING){
        
        vc.meetingModel = cell.meetingModel;
        vc.costNumber = (self.endTime - self.beginTime) * cell.meetingModel.conferencePrice.floatValue;
    }
    else {
        vc.siteModel = cell.siteModel;
        vc.costNumber = (self.endTime - self.beginTime) * cell.siteModel.sitePrice.floatValue;
    }
    [self.navigationController pushViewController:vc animated:YES];    
}

-(void)selectTimeWithCell:(WOTReservationsMeetingCell *)cell Time:(CGFloat)time
{
    if (cell.index.row != selectIndex.row) {
        self.beginTime = 0;
        self.endTime = 0;
    }
    if (self.beginTime == self.endTime && self.endTime == 0) {
        self.beginTime = time;
        self.endTime = self.beginTime+0.5;
    }
    else if (time ==  self.beginTime && self.beginTime == self.endTime-0.5) {
        self.beginTime = self.endTime = 0;
    }
    else if (time<self.beginTime) {
        self.beginTime = time;
    }
    else if (time>=self.endTime) {
        self.endTime = time+0.5;
    }
    else if (time>self.beginTime && time<self.endTime) {
        if (time == self.endTime-0.5) {
            self.endTime = time;
        }
        else {
            self.endTime = time+0.5;
        }
    }
    
}

#pragma mark - table delegate  & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectIndex && selectIndex.row == indexPath.row) {
        return 410;
    }
    return 240;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTReservationsMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTReservationsMeetingCell" forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[WOTReservationsMeetingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTReservationsMeetingCell"];
    }
    [cell setupView];
    cell.delegate = self;
    
    if (tableList) {
        id model = tableList[indexPath.row];
        [cell setInquireTime:inquireTime];
        
        if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
            [cell setMeetingModel:model];
        }
        else {
            [cell setSiteModel:model];
        }
        if (selectIndex && selectIndex.row == indexPath.row) {
            [cell.selectTimeScroll setBeginTime:self.beginTime endTime:self.endTime];
            [cell.selectTimeScroll setScrollOffsetX:ofoset.x];
        }
        else {
            [cell.selectTimeScroll setBeginTime:0 endTime:0];
            [cell.selectTimeScroll setScrollOffsetX:0];
        }
        
        cell.index = indexPath;
    } else {
        NSLog(@"测试：没有数据");
    }
    
    
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    WOTReservationsMeetingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGPoint offset = cell.selectTimeScroll.contentOffset;
    NSLog(@"----------%f", offset.x);
    ofoset = offset;
    NSIndexPath *index = selectIndex;
    selectIndex = indexPath;
    [self.table reloadRowsAtIndexPaths:@[selectIndex] withRowAnimation:NO];
    if (index) {
        [self.table reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
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
