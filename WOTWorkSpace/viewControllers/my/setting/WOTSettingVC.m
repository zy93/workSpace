//
//  WOTSettingVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSettingVC.h"
#import "header.h"

#import "WOTSettingCell.h"

@interface WOTSettingVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WOTSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    [self loadSubViews];
    [self configNaviBackItem];
    self.navigationItem.title = @"设置";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)loadSubViews{
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = CLEARCOLOR;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView.backgroundColor = CLEARCOLOR;
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTSettingCell" bundle:nil] forCellReuseIdentifier:@"settingCellID"];
    self.navigationItem.title = @"设置";
    
    [self.view addSubview:_tableView];
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
            return 6;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 60;
            break;
        case 1:
            return 60;
            break;
        case 2:
            return 60;
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
        return  15;
    }
  
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTSettingCell *settingcell = [tableView dequeueReusableCellWithIdentifier:@"settingCellID" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == [self.tableView numberOfRowsInSection:indexPath.section]-1) {
            [settingcell.valueLabel setHidden:NO];
             settingcell.valueLabel.text = @"122.M";
            [settingcell.lineVIew setHidden:YES];
        } else {
            [settingcell.valueLabel setHidden:YES];
           
            
        }
        NSArray *nameArray = [[NSArray alloc]initWithObjects:@"个人资料",@"通知设置",@"修改密码",@"设置手势密码",@"设置指纹",@"清除缓存",nil];
        [settingcell.signoutBtn setHidden:YES];
        settingcell.nameLabel.text = nameArray[indexPath.row];

    } else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            [settingcell.valueLabel setHidden:NO];
            settingcell.valueLabel.text = @"400-8911-891";
        } else {
            [settingcell.valueLabel setHidden:YES];
 
        }
        if (indexPath.row == [self.tableView numberOfRowsInSection:indexPath.section]-1) {
            [settingcell.lineVIew setHidden:YES];
        }
         [settingcell.signoutBtn setHidden:YES];
        NSArray *nameArray1 = [[NSArray alloc]initWithObjects:@"联系我们",@"关于众创空间",@"分享APP",@"检查新版本",nil];
        settingcell.nameLabel.text = nameArray1[indexPath.row];
    }else {
        [settingcell.valueLabel setHidden:YES];
        [settingcell.nameLabel setHidden:YES];
        [settingcell.nextImage setHidden:YES];
        [settingcell.signoutBtn setHidden:NO];
        [settingcell.lineVIew setHidden:YES];
        
    }
    
    return settingcell;
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
