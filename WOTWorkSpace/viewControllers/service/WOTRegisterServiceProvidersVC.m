//
//  WOTRegisterServiceProvidersVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTRegisterServiceProvidersVC.h"
#import "WOTServiceProvidersCategoryVC.h"
#import "WOTRegisterServiceProvidersCell.h"
#import "WOTSubmitRegisterServiceCell.h"

@interface WOTRegisterServiceProvidersVC () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *tableList;
    NSMutableArray *tableSubtitleList;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation WOTRegisterServiceProvidersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    [self addData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"服务商申请";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)addData{
    NSArray *tableList1 = @[@"企业logo：", @"企业名称：", @"经营范围：", @"联系人：", @"联系方式：", @"服务商类别：", @"服务社区："] ;
    NSArray *tableList2 = @[@"提交"];
    tableList = [@[tableList1, tableList2] mutableCopy];
    tableSubtitleList = [@[@"请选择企业logo", @"请输入企业名称", @"请输入经营范围", @"请输入联系人", @"请输入联系方式", @"选择服务商类别", @"选择服务社区"] mutableCopy];
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.table reloadData];
}

#pragma mark - action
-(void)pushVCByVCName:(NSString *)vcName
{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:vcName];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table delgate & data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = tableList[section];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }
    else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WOTRegisterServiceProvidersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTRegisterServiceProvidersCell"];
        if (cell == nil) {
            cell = [[WOTRegisterServiceProvidersCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTRegisterServiceProvidersCell"];
        }
        NSArray *arr = tableList[indexPath.section];
        [cell.titleLab setText:arr[indexPath.row]];
        [cell.contentText setPlaceholder:tableSubtitleList[indexPath.row]];
        if (indexPath.row == 0) {
            cell.contentText.enabled = NO;
            [cell.contentText setHidden:YES];
            [cell.iconImg setHidden:NO];
        }
        else if (indexPath.row==5 || indexPath.row == 6) {
            cell.contentText.enabled = NO;
            [cell.contentText setHidden:NO];
            [cell.iconImg setHidden:YES];
            
        }
        else
        {
            cell.contentText.enabled = YES;
            [cell.contentText setHidden:NO];
            [cell.iconImg setHidden:YES];
            
        }
        return cell;
    }
    else {
        WOTSubmitRegisterServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTSubmitRegisterServiceCell"];
        if (cell == nil) {
            cell = [[WOTSubmitRegisterServiceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTSubmitRegisterServiceCell"];
        }
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row==5 || indexPath.row==6) {
            [self pushVCByVCName:@"WOTServiceProvidersCategoryVC"];
        }
    }
    else {
        //提交
    }
    
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
