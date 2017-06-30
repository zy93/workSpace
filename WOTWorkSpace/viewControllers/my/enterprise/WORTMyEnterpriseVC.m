//
//  WORTMyEnterpriseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WORTMyEnterpriseVC.h"
#import "header.h"
#import "WOTMyEnterPriseCell.h"
#import "WOTCreateEnterpriseVC.h"
@interface WORTMyEnterpriseVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WORTMyEnterpriseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavi];
    [self loadSubViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNavi{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的企业";
    
}
-(void)loadSubViews{
    
    _tableVIew.dataSource = self;
    _tableVIew.delegate = self;
    [_tableVIew registerNib:[UINib nibWithNibName:@"WOTMyEnterPriseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"myenterpriseCellID"];
   
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyEnterPriseCell *enterprisecell = [tableView dequeueReusableCellWithIdentifier:@"myenterpriseCellID" forIndexPath:indexPath];
    return enterprisecell;
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
