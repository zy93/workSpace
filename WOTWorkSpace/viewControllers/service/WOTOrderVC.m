//
//  WOTOrderVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderVC.h"
#import "WOTOrderForInfoCell.h"
#import "WOTOrderForBookStationCell.h"
#import "WOTOrderForSiteCell.h"
#import "WOTOrderForServiceInfoCell.h"
#import "WOTPaymentTypeCell.h"
#import "WOTOrderForSelectCell.h"
#import "WOTOrderForPaymentCell.h"
#import "WOTOrderForAmountCell.h"

#define infoCell @"infoCell"
#define bookStationCell @"bookStationCell"
#define serviceCell @"serviceCell"
#define payTypeCell @"payTypeCell"
#define selectCell @"selectCell"
#define siteCell @"siteCell"
#define amountCell @"amountCell"
#define uitableCell @"uitableCell"
#define paymentCell @"paymentCell"

@interface WOTOrderVC () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *tableList;
    
    NSIndexPath *payTypeIndex;//个人、企业支付
    NSIndexPath *paymentIndex;//微信、支付宝支付
    
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation WOTOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.table.separatorStyle = UITableViewCellSelectionStyleNone;
    [self configNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"确认订单"; 
}

-(void)setIsBookStation:(BOOL)isBookStation
{
    _isBookStation = isBookStation;
    
    NSArray *list1 = nil;
    
    if (_isBookStation) {
        list1 = @[infoCell, bookStationCell, serviceCell, payTypeCell, selectCell, selectCell];
    }
    else {
        list1 = @[infoCell, siteCell, serviceCell, payTypeCell, selectCell, selectCell];
    }
    
    NSArray *list2 = @[uitableCell,paymentCell,paymentCell];
    NSArray *list3 = @[amountCell];
    
    tableList = @[list1, list2, list3];
    [self.table reloadData];
    
}
#pragma mark - action
- (IBAction)clickSubmitBtn:(id)sender {
    
    if (self.isBookStation) {
        
    }
    else {
        [WOTHTTPNetwork meetingReservationsWithSpaceId:self.spaceId conferenceId:self.conferenceId startTime:self.startTime endTime:self.endTime response:^(id bean, NSError *error) {
            
        }];
    }
    
    
}

#pragma mark - table delegate & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *list = tableList[section];
    return list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *list = tableList[indexPath.section];
    NSString *cellType = list[indexPath.row];
    
    if ([cellType isEqualToString:infoCell]) {
        return 198;
    }
    else if ([cellType isEqualToString:bookStationCell]) {
        return 169;
    }
    else if ([cellType isEqualToString:siteCell]) {
        return 65;
    }
    else if ([cellType isEqualToString:serviceCell]) {
        return 176;
    }
    else if ([cellType isEqualToString:payTypeCell]) {
        return 50;
    }
    else if ([cellType isEqualToString:selectCell]) {
        return 50;
    }
    else if ([cellType isEqualToString:uitableCell]) {
        return 30;
    }
    else if ([cellType isEqualToString:paymentCell]) {
        return 50;
    }
    else // ([cellType isEqualToString:amountCell])
    {
        return 50;
    }
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return 0;
//    }
//    return 15;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *list = tableList[indexPath.section];
    NSString *cellType = list[indexPath.row];
    
    if ([cellType isEqualToString:infoCell]) {
        WOTOrderForInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForInfoCell"];
        if (cell == nil) {
            cell = [[WOTOrderForInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForInfoCell"];
        }
        return cell;
    }
    else if ([cellType isEqualToString:bookStationCell]) {
        WOTOrderForBookStationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForBookStationCell"];
        if (cell == nil) {
            cell = [[WOTOrderForBookStationCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForBookStationCell"];
        }
        return cell;
    }
    else if ([cellType isEqualToString:siteCell]) {
        WOTOrderForSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForSiteCell"];
        if (cell == nil) {
            cell = [[WOTOrderForSiteCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForSiteCell"];
        }
        //
        [cell.reservationsDateLab setText:[self.startTime substringWithRange:NSMakeRange(0, 10)]];
        NSString *str = [NSString stringWithFormat:@"%@-%@",
                         [self.startTime substringWithRange:NSMakeRange(11, 5)],
                         [self.endTime   substringWithRange:NSMakeRange(11, 5)]];
        
        [cell.reservationsTimeLab setText:str];

        
        return cell;
    }
    else if ([cellType isEqualToString:serviceCell]) {
        WOTOrderForServiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForServiceInfoCell"];
        if (cell == nil) {
            cell = [[WOTOrderForServiceInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForServiceInfoCell"];
        }
        return cell;
    }
    else if ([cellType isEqualToString:payTypeCell]) {
        WOTPaymentTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTPaymentTypeCell"];
        if (cell == nil) {
            cell = [[WOTPaymentTypeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTPaymentTypeCell"];
        }
        return cell;
    }
    else if ([cellType isEqualToString:selectCell]) {
        WOTOrderForSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForSelectCell"];
        if (cell == nil) {
            cell = [[WOTOrderForSelectCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForSelectCell"];
        }
        if (indexPath.row==4) {
            [cell.titleLab setText:@"发票信息"];
            [cell.subtitleLab setText:@"北京物联港科技发展有限公司"];
        }
        else {
            [cell.titleLab setText:@"代金券"];
            [cell.subtitleLab setText:@"无代金券可用"];
        }
        return cell;
    }
    else if ([cellType isEqualToString:uitableCell]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCelll"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCelll"];
        }
        [cell.textLabel setText:@"电子支付"];
//        cell.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);
        
        return cell;
    }
    else if ([cellType isEqualToString:paymentCell]) {
        WOTOrderForPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForPaymentCell"];
        if (cell == nil) {
            cell = [[WOTOrderForPaymentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForPaymentCell"];
        }
        if (indexPath.row == 1) {
            cell.alipay = YES;
        }
        else {
            cell.alipay = NO;
        }
        if (indexPath.row == paymentIndex.row) {
            cell.select = YES;
        }
        else {
            cell.select = NO;
        }
            
        return cell;
    }
    else // ([cellType isEqualToString:amountCell])
    {
        WOTOrderForAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForAmountCell"];
        if (cell == nil) {
            cell = [[WOTOrderForAmountCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForAmountCell"];
        }
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row == 4 || indexPath.row == 5) {
            payTypeIndex = indexPath;
//            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
//        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 1 || indexPath.row == 2) {
            paymentIndex = indexPath;
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
}


//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    [lab setText:@"您可以在使用前2小时取消预定"];
//    [lab setTextAlignment:NSTextAlignmentCenter];
//    [view addSubview:lab];
//    [view setBackgroundColor:UIColorFromRGB(0x12fdff)];
//    return view;
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
