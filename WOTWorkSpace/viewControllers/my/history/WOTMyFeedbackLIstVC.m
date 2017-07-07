//
//  WOTMyFeedbackLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyFeedbackLIstVC.h"
#import "WOTFeedBackLIstCell.h"
@interface WOTMyFeedbackLIstVC ()

@end

@implementation WOTMyFeedbackLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTFeedBackLIstCell" bundle:nil] forCellReuseIdentifier:@"WOTFeedBackLIstCellID"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTFeedBackLIstCell *feedbackcell = [tableView dequeueReusableCellWithIdentifier:@"WOTFeedBackLIstCellID" forIndexPath:indexPath];
    return feedbackcell;
    
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
