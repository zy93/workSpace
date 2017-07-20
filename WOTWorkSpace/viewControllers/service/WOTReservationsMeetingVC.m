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
#import "WOTWorkspaceListVC.h"
#import "WOTDatePickerView.h"
#import "WOTMeetingListModel.h"
#import "WOTMeetingReservationsModel.h"


@interface WOTReservationsMeetingVC () <UITableViewDelegate, UITableViewDataSource, WOTReservationsMeetingCellDelegate>
{
    NSArray *tableList;
    NSIndexPath *selectIndex;
    NSMutableArray *invalidTimeList; //失效时间记录
    NSString *inquireTime;//查询日期;
    
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewCenter;
@property (weak, nonatomic) IBOutlet UIButton *tomorrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectTimeBtn;
@property (nonatomic,strong) WOTDatePickerView *datepickerview;



@end

@implementation WOTReservationsMeetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavi];
    [self setupView];
    [self.table registerNib:[UINib nibWithNibName:@"WOTReservationsMeetingCell" bundle:nil] forCellReuseIdentifier:@"WOTReservationsMeetingCell"];
    
    _spaceId = @(56);
    inquireTime = [NSDate getNewTimeZero];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    selectIndex = nil;
    [self createRequest];

}

-(void)configNavi
{
    self.navigationItem.title = @"预定会议室";
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"北京" style:UIBarButtonItemStylePlain target:self action:@selector(selectSpace:)];
    [self.navigationItem setRightBarButtonItem:doneItem];
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    self.navigationController.navigationBar.translucent = NO; //有个万恶的黑色
}

-(void)setupView
{
    __weak typeof(self) weakSelf = self;
    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height - [WOTUitls GetLengthAdaptRate]*300, self.view.frame.size.width, 300)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day){
        weakSelf.datepickerview.hidden = YES;
        NSLog(@"%ld年%ld月%ld日",year,month,day);
        inquireTime = [NSString stringWithFormat:@"%02d/%02d/%02d 00:00:00",(int)year, (int)month, (int)day];
    };
    
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden  = YES;
}

#pragma mark - request
-(void)createRequest
{
    [WOTHTTPNetwork getMeetingRoomListWithSpaceId:self.spaceId response:^(id bean, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error);
            return ;
        }
        WOTMeetingListModel_msg *model = bean;
        tableList = model.msg;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
    }];
}


#pragma mark - action
- (IBAction)today:(id)sender {
    self.indicatorViewCenter.constant = 0;
    self.todayBtn.selected = YES;
    self.tomorrowBtn.selected = NO;
    self.selectTimeBtn.selected = NO;
    inquireTime = [NSDate getNewTimeZero];
}
- (IBAction)tomorrow:(id)sender {
    self.indicatorViewCenter.constant = CGRectGetMidX(self.tomorrowBtn.frame)-CGRectGetMidX(self.todayBtn.frame);
    self.todayBtn.selected = NO;
    self.tomorrowBtn.selected = YES;
    self.selectTimeBtn.selected = NO;
    inquireTime = [NSDate getTomorrowTimeZero];
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
    WOTWorkspaceListVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTWorkspaceListVC"];
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
    vc.conferenceId = cell.model.conferenceId;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    vc.isBookStation = NO;
}

-(void)selectTimeWithCell:(WOTReservationsMeetingCell *)cell Time:(CGFloat)time
{
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
        return 390;
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
    cell.delegate = self;
    if (selectIndex && selectIndex.row == indexPath.row) {
        [cell.selectTimeScroll setBeginTime:self.beginTime endTime:self.endTime];
        [cell.selectTimeScroll setInvalidBtnTimeList:invalidTimeList];
    }
    WOTMeetingListModel *model = tableList[indexPath.row];
    [cell setModel:model];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    selectIndex = indexPath;
    WOTReservationsMeetingCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    
//    @"2017/07/13 00:00:00"
    [WOTHTTPNetwork getMeetingReservationsTimeWithSpaceId:self.spaceId conferenceId:cell.model.conferenceId startTime:inquireTime response:^(id bean, NSError *error) {
        
        WOTMeetingReservationsModel_msg *mod = bean;
        NSMutableArray *reserList = [NSMutableArray new];
        for (WOTMeetingReservationsModel * model in  mod.msg) {
            NSArray *arr = [NSString getReservationsTimesWithStartTime:model.startTime endTime:model.endTime];
            [reserList addObject:arr];
        }
        invalidTimeList = reserList;
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.selectTimeScroll setInvalidBtnTimeList:reserList];
        });
    }];
    [self.table reloadRowsAtIndexPaths:@[selectIndex] withRowAnimation:NO];
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
