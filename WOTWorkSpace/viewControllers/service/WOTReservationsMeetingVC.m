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
#import "WOTDatePickerView.h"

@interface WOTReservationsMeetingVC () <UITableViewDelegate, UITableViewDataSource, WOTReservationsMeetingCellDelegate>
{
    NSIndexPath *selectIndex;
    NSMutableArray *selectTimeList; //已选时间记录
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewCenter;
@property (weak, nonatomic) IBOutlet UIButton *tomorrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectTimeBtn;
@property(nonatomic,strong)WOTDatePickerView *datepickerview;

@end

@implementation WOTReservationsMeetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavi];
    [self loadViews];
    [self.table registerNib:[UINib nibWithNibName:@"WOTReservationsMeetingCell" bundle:nil] forCellReuseIdentifier:@"WOTReservationsMeetingCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)configNavi
{
    self.navigationItem.title = @"预定会议室";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)loadViews{
    __weak typeof(self) weakSelf = self;
    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height - [WOTUitls GetLengthAdaptRate]*300, self.view.frame.size.width, 300)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day){
        weakSelf.datepickerview.hidden = YES;
        NSLog(@"%ld年%ld月%ld日",year,month,day);
    };
    
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden  = YES;
}

#pragma mark - action
- (IBAction)today:(id)sender {
    self.indicatorViewCenter.constant = 0;
    self.todayBtn.selected = YES;
    self.tomorrowBtn.selected = NO;
    self.selectTimeBtn.selected = NO;
}
- (IBAction)tomorrow:(id)sender {
    self.indicatorViewCenter.constant = CGRectGetMidX(self.tomorrowBtn.frame)-CGRectGetMidX(self.todayBtn.frame);
    self.todayBtn.selected = NO;
    self.tomorrowBtn.selected = YES;
    self.selectTimeBtn.selected = NO;
}
- (IBAction)selectTime:(id)sender {
    self.indicatorViewCenter.constant = CGRectGetMidX(((UIButton *)sender).frame) -CGRectGetMidX(self.todayBtn.frame);
    self.todayBtn.selected = NO;
    self.tomorrowBtn.selected = NO;
    self.selectTimeBtn.selected = YES;
    _datepickerview.hidden = NO;
}




#pragma mark - cell delegate
-(void)submitReservations
{
    WOTOrderVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTOrderVC"];
    [self.navigationController pushViewController:vc animated:YES];
    vc.isBookStation = NO;
}

-(void)selectTimeWithTag:(NSInteger)tag
{
    if (!selectTimeList) {
        selectTimeList = [NSMutableArray new];
    }
    for (NSNumber *num in selectTimeList) {
        if ([num integerValue] == tag) {
            [selectTimeList removeObject:num];
            return;
        }
    }
    [selectTimeList addObject:@(tag)];
}

#pragma mark - table delegate  & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
        [cell.selectTimeScroll setSelectBtnTagList:selectTimeList];
    }
    [cell.selectTimeScroll setBeginValue:8 endValue:23];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    selectIndex = indexPath;
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
