//
//  WOTWorkspaceListVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/17.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTWorkspaceListVC.h"
#import "WOTReservationsMeetingVC.h"
#import "WOTServiceNaviController.h"
#import "WOTSpaceModel.h"


@interface WOTWorkspaceListVC () <UITableViewDelegate, UITableViewDataSource>
{
//    NSArray *tableList;
    NSDictionary *tableDic;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation WOTWorkspaceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self config];
    [self createRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)config{
    self.navigationItem.title = @"选择空间";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}


#pragma mark - request
-(void)createRequest
{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getAllSpaceWithCity:nil block:^(id bean, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error);
            return ;
        }
        WOTSpaceModel_msg *list = bean;
//        tableList = list.msg;
        tableDic = [self sortByCity:list.msg];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.table reloadData];
        });
    }];
}


-(NSDictionary *)sortByCity:(NSArray *)array
{
    //先看有哪些城市
    NSMutableArray *cityList = [NSMutableArray new];
    
    for (WOTSpaceModel *model in array) {
        //
        BOOL isHaveCity = NO;
        for (NSString *city in array) {
            if ([model.city isEqualToString:city]) {
                isHaveCity = YES;
                break;
            }
        }
        if (!isHaveCity) {
            [cityList addObject:model.city];
        }
    }
    
    NSMutableDictionary *resultDic = [NSMutableDictionary new];
    for (NSString *cityKey in cityList) {
        [resultDic setObject:[NSMutableArray new] forKey:cityKey];
    }
    
    for (WOTSpaceModel *model in array) {
        NSMutableArray *arr = resultDic[model.city];
        [arr addObject:model];
        [resultDic setObject:arr forKey:model.city];
    }
    
    return resultDic;
}


#pragma mark - table delegate & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableDic.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arrKey = [tableDic allKeys];
    NSString *key = arrKey[section];
    NSArray *modelList = tableDic[key];
    return modelList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectSpaceCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectSpaceCell"];
    }
    NSArray *arrKey = [tableDic allKeys];
    NSString *key = arrKey[indexPath.section];
    NSArray *modelList = tableDic[key];
    
    WOTSpaceModel *model = modelList[indexPath.row];
    [cell.textLabel setText:model.spaceName];
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *arrKey = [tableDic allKeys];
    NSString *key = arrKey[section];
    return key;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *arrKey = [tableDic allKeys];
    NSString *key = arrKey[indexPath.section];
    NSArray *modelList = tableDic[key];
    
    WOTSpaceModel *model = modelList[indexPath.row];
    UIViewController *vc = [(WOTBaseNavigationController*)self.navigationController getPreviousViewController];
    ((WOTReservationsMeetingVC*)vc).spaceId = model.spaceId;
    [self.navigationController popViewControllerAnimated:YES];
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
