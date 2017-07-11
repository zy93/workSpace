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
#import "WOTOrderForSelectCell.h"
#import "WOTOrderForPaymentCell.h"
#import "WOTOrderForAmountCell.h"


@interface WOTOrderVC () <UITableViewDataSource, UITableViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation WOTOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 210;
    }
    else if (indexPath.row==1) {
        if (self.isBookStation) {
            return 169;
        }
        return 85;
    }
    else if (indexPath.row==2) {
        return 134;
    }
    else if (indexPath.row==3) {
        return 59;
    }
    else if (indexPath.row==4 || indexPath.row == 5) {
        return 59;
    }
    else if (indexPath.row==6 || indexPath.row == 7) {
        return 49;
    }
    else {
        return 52;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WOTOrderForInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForInfoCell"];
        if (cell == nil) {
            cell = [[WOTOrderForInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForInfoCell"];
        }
        return cell;
    }
    else if (indexPath.row == 1) {
        
        if (self.isBookStation) {
            WOTOrderForBookStationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForBookStationCell"];
            if (cell == nil) {
                cell = [[WOTOrderForBookStationCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForBookStationCell"];
            }
            return cell;
        }
        else {
            WOTOrderForSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForSiteCell"];
            if (cell == nil) {
                cell = [[WOTOrderForSiteCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForSiteCell"];
            }
            return cell;
        }
        
    }
    else if (indexPath.row == 2) {
        WOTOrderForServiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForServiceInfoCell"];
        if (cell == nil) {
            cell = [[WOTOrderForServiceInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForServiceInfoCell"];
        }
        return cell;
    }
    else if (indexPath.row == 3 || indexPath.row == 4) {
        WOTOrderForSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForSelectCell"];
        if (cell == nil) {
            cell = [[WOTOrderForSelectCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForSelectCell"];
        }
        if (indexPath.row==3) {
            [cell.titleLab setText:@"发票信息"];
            [cell.subtitleLab setText:@"北京物联港科技发展有限公司"];
        }
        else {
            [cell.titleLab setText:@"代金券"];
            [cell.subtitleLab setText:@"无代金券可用"];
        }
        return cell;
    }
    else if (indexPath.row == 5 || indexPath.row == 6) {
        WOTOrderForPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForPaymentCell"];
        if (cell == nil) {
            cell = [[WOTOrderForPaymentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForPaymentCell"];
        }
        
        return cell;
    }
    else if (indexPath.row == 7) {
        WOTOrderForAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForAmountCell"];
        if (cell == nil) {
            cell = [[WOTOrderForAmountCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForAmountCell"];
        }
        [cell.titleLab setText:@"￥298"];
        return cell;
    }
    else if (indexPath.row == 6) {
        WOTOrderForInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForInfoCell"];
        if (cell == nil) {
            cell = [[WOTOrderForInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForInfoCell"];
        }
        return cell;
    
    }
    else if (indexPath.row == 7) {
        WOTOrderForInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForInfoCell"];
        if (cell == nil) {
            cell = [[WOTOrderForInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForInfoCell"];
        }
        return cell;
    }
    else {
        WOTOrderForInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForInfoCell"];
        if (cell == nil) {
            cell = [[WOTOrderForInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForInfoCell"];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [lab setText:@"您可以在使用前2小时取消预定"];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:lab];
    [view setBackgroundColor:UIColorFromRGB(0x12fdff)];
    return view;
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
