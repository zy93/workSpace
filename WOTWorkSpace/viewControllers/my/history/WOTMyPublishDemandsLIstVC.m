//
//  WOTMyPublishDemandsLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyPublishDemandsLIstVC.h"
#import "WOTFeedBackLIstCell.h"
@interface WOTMyPublishDemandsLIstVC ()

@end

@implementation WOTMyPublishDemandsLIstVC

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
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTFeedBackLIstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTFeedBackLIstCellID" forIndexPath:indexPath];
    
    cell.tagLabelArray = @[@"软件服务-软件集成",@"金融-理财培训"];
    [[WOTConfigThemeUitls shared] loadtagsBtn:cell.tagLabelArray superView:cell.tagsView];
    return cell;
    
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
