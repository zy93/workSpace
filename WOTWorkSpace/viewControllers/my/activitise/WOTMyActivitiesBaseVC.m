//
//  WOTMyActivitiesBaseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyActivitiesBaseVC.h"
#import "WOTMyActivitiesCell.h"
@interface WOTMyActivitiesBaseVC ()

@end

@implementation WOTMyActivitiesBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView.backgroundColor = CLEARCOLOR;
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyActivitiesCell" bundle:nil] forCellReuseIdentifier:@"WOTMyActivitiesCellID"];
 
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyActivitiesCell *activityCell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyActivitiesCellID" forIndexPath:indexPath];
    activityCell.activityTitle.text = @"单身交流会！！！";
    activityCell.activityTime.text = @"07/11 15:00 -- 07/12 16:00";
    activityCell.activityLocation.text = @"阳光100.优客工厂";
    return activityCell;

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
