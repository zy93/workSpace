//
//  WOTMyVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyVC.h"

#import "WOTMyuserCell.h"
#import "WOTMycommonCell.h"
#import "WOTMyOrderCell.h"
#import "WOTMyActivitiesVC.h"
#import "WOTMyHistoryVC.h"
@interface WOTMyVC ()<WOTOrderCellDelegate,WOTOMyCellDelegate>
@property(nonatomic,strong)WOTSettingVC *settingvc;
@property(nonatomic,strong)WOTPersionalInformation *persionalVC;
@end

@implementation WOTMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNaviBackItem];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyuserCell" bundle:nil] forCellReuseIdentifier:@"WOTMyuserCellID"];
    [self.tableView registerClass:[WOTMycommonCell class] forCellReuseIdentifier:@"mycommonCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyOrderCell" bundle:nil] forCellReuseIdentifier:@"myorderCellID"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar setHidden:YES];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        default:
            break;
    }
     return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 240;
            break;
        case 1:
            return 125;
            break;
        case 2:
            return 50;
            break;
        default:
            break;
    }
    return  0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 0;
    } else {
        return 10;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *commoncell;
    
    if (indexPath.section == 0) {
        WOTMyuserCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyuserCellID" forIndexPath:indexPath];
        mycell.userName.text = @"张小宝";
        mycell.constellation.text = @"狮子座";
        mycell.signature.text = @"如果你不能很好的表达你的想法，说明你还不够了解啊";
        mycell.headerImage.image = [UIImage imageNamed:@"defaultHeaderVIew"];
        mycell.bgImage.image = [UIImage imageNamed:@"mybgimage"];
        mycell.mycelldelegate = self;
    
        commoncell = mycell;
    } else if (indexPath.section == 1){
        WOTMyOrderCell *ordercell = [tableView dequeueReusableCellWithIdentifier:@"myorderCellID" forIndexPath:indexPath];
        ordercell.celldelegate = self;
        commoncell = ordercell;
    } else {
        WOTMycommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycommonCellID" forIndexPath:indexPath];
        NSArray *titlearray = [NSArray arrayWithObjects:@"我的企业",@"我的活动",@"我的历史",nil];
        NSArray *imageNameArray = [NSArray arrayWithObjects:@"enterprise",@"activities",@"history",nil];
        cell.nameLabel.text = titlearray[indexPath.row];
        cell.cellImage.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
        commoncell = cell;
    }
    
    return commoncell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            //enter to mymainvc
            break;
        case 1:
            break;
        case 2:
            if (indexPath.row ==0 ) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"My" bundle:[NSBundle mainBundle]];
                WORTMyEnterpriseVC *myenterprisevc = [storyboard instantiateViewControllerWithIdentifier:@"WORTMyEnterpriseVCID"];
                [self.navigationController pushViewController:myenterprisevc animated:YES];
                
                
            } else if (indexPath.row == 1){
                WOTMyActivitiesVC *activityvc = [[WOTMyActivitiesVC alloc]init];
                [self.navigationController pushViewController:activityvc animated:YES];
            } else {
                WOTMyHistoryVC *historyvc = [[WOTMyHistoryVC alloc]init];
                [self.navigationController pushViewController:historyvc animated:YES];
            }
        default:
            break;
    }
}


/**订单celldelegate*/
-(void)showAllOrderList{
    WOTAllOrderListVC *station_ordervc = [[WOTAllOrderListVC alloc]init];
    [self.navigationController pushViewController:station_ordervc animated:YES];
    
}

-(void)showStationOrderList{
    WOTOrderLIstVC *station_ordervc = [[WOTOrderLIstVC alloc]init];
    station_ordervc.vctype = WOTPageMenuVCTypeStation;
    [self.navigationController pushViewController:station_ordervc animated:YES];
}
-(void)showMettingRoomOrderList{
    WOTOrderLIstVC *mettingroom_ordervc = [[WOTOrderLIstVC alloc]init];
    mettingroom_ordervc.vctype = WOTPageMenuVCTypeMetting;
    [self.navigationController pushViewController:mettingroom_ordervc animated:YES];

}

-(void)showSettingVC{
    _settingvc = [[WOTSettingVC alloc]init];
    
    [self.navigationController pushViewController:_settingvc animated:YES];
}
-(void)showPersonalInformationVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"My" bundle:[NSBundle mainBundle]];
    
    _persionalVC = [storyboard instantiateViewControllerWithIdentifier:@"WOTPersionalInformationID"];
    [self.navigationController pushViewController:_persionalVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
