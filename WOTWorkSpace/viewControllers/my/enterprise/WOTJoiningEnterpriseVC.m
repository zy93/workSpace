//
//  WOTJoiningEnterpriseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTJoiningEnterpriseVC.h"
#import "WOTMyEnterPriseCell.h"
@interface WOTJoiningEnterpriseVC ()
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation WOTJoiningEnterpriseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.tableView.showsVerticalScrollIndicator = NO;
     [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyEnterPriseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"myenterpriseCellID"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyEnterPriseCell *enterprisecell = [tableView dequeueReusableCellWithIdentifier:@"myenterpriseCellID" forIndexPath:indexPath];
    enterprisecell.enterpariseName.text = @"北京物联港科技发展有限公司";
    enterprisecell.joinEnterpriseTime.text = @"2017-06-12";
    enterprisecell.enterpriseHeaderImage.image = [UIImage imageNamed:@"myenterprise_logo"];
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
