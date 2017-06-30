//
//  WOTMyVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyVC.h"
#import "header.h"

#import "WOTMyCell.h"
#import "WOTMycommonCell.h"
#import "WOTMyOrderCell.h"

@interface WOTMyVC ()<UITableViewDataSource,UITableViewDelegate,WOTOrderCellDelegate>
@property(nonatomic,strong)WOTSettingVC *settingvc;
@end

@implementation WOTMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = White;
    [self configNaviItem];
    [self loadSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSubViews{
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = White;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[WOTMyCell class] forCellReuseIdentifier:@"myCellID"];
     [self.tableView registerClass:[WOTMycommonCell class] forCellReuseIdentifier:@"mycommonCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyOrderCell" bundle:nil] forCellReuseIdentifier:@"myorderCellID"];
    self.navigationItem.title = @"我";
    
    [self.view addSubview:_tableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
    
}
-(void)viewWillLayoutSubviews{
   [self.tableView layoutConstraintsToView:self.view];
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
            return 100;
            break;
        case 1:
            return 100;
            break;
        case 2:
            return 80;
            break;
        default:
            break;
    }
    return  0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  15;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *commoncell;
    
    if (indexPath.section == 0) {
        WOTMyCell *mycell = [_tableView dequeueReusableCellWithIdentifier:@"myCellID" forIndexPath:indexPath];
        mycell.selectionStyle = UITableViewCellSelectionStyleNone;
        mycell.accountName.text = @"xxx";
        mycell.signature.text = @"如果你不能简洁的表达你的想法，只能说明你不够了解他";
        commoncell = mycell;
    } else if (indexPath.section == 1){
        WOTMyOrderCell *ordercell = [tableView dequeueReusableCellWithIdentifier:@"myorderCellID" forIndexPath:indexPath];
        ordercell.celldelegate = self;
        commoncell = ordercell;
    } else {
        WOTMycommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycommonCellID" forIndexPath:indexPath];
        NSArray *titlearray = [NSArray arrayWithObjects:@"我的企业",@"我的活动",@"我的历史",nil];
        cell.nameLabel.text = titlearray[indexPath.row];
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
                
            } else {
                
            }
        default:
            break;
    }
}
-(void)configNaviItem{
    UIButton *settingbtn = [[UIButton alloc]init];
    [settingbtn setFrame:CGRectMake(0,0,25,25)];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [settingbtn addTarget:self action:@selector(popToSettingVC) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:settingbtn];
    
}
-(void)popToSettingVC{
    _settingvc = [[WOTSettingVC alloc]init];

    [self.navigationController pushViewController:_settingvc animated:YES];
};

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
