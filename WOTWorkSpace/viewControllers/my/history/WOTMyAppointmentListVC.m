//
//  WOTMyAppointmentListVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyAppointmentListVC.h"

@interface WOTMyAppointmentListVC ()

@end

@implementation WOTMyAppointmentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyAppointmentCell" bundle:nil] forCellReuseIdentifier:@"WOTMyAppointmentCellID"];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyAppointmentCell *appointmentcell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyAppointmentCellID" forIndexPath:indexPath];
    appointmentcell.appointmentCommunityValue.text = @"方圆大厦--众创空间";
    appointmentcell.appointmentObjectValue.text =@"北京物联港科技发展有限公司";
    appointmentcell.appointmentTimeValue.text = @"2017-07-11 12:30:23";
    appointmentcell.appointmentReasionValue.text = @"讨论新项目需求";
    return appointmentcell;
    
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
