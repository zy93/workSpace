//
//  WOTServiceProvidersCategoryVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTServiceProvidersCategoryVC.h"
#import "WOTServiceProvidersCell.h"
#import "WOTServiceProvidersCategoryCell.h"

@interface WOTServiceProvidersCategoryVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *table1Dict;
    NSArray *table2List;
}
@property (weak, nonatomic) IBOutlet UITableView *table1;
@property (weak, nonatomic) IBOutlet UITableView *table2;


@end

@implementation WOTServiceProvidersCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"选择服务商类别";
    
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)loadData
{
    NSDictionary *dic = [self readPlistFileForFileName:@"ServiceCategory"];
    table1Dict = dic;
    table2List = dic[[dic allKeys].firstObject];
    [self.table1 reloadData];
    [self.table2 reloadData];
}

#pragma mark - plist file
-(NSDictionary *)readPlistFileForFileName:(NSString *)fileName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    //添加一项内容    
//    //获取应用程序沙盒的Documents目录
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *plistPath1 = [paths objectAtIndex:0];
    return dataDic;
    
}

#pragma mark - table delegate & data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.table1]) {
        return table1Dict.count;
    }
    else {
        return table2List.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([tableView isEqual:self.table1]) {
        WOTServiceProvidersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTServiceProvidersCell"];
        if (cell == nil) {
            cell = [[WOTServiceProvidersCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTServiceProvidersCell"];
        }
        NSArray *arr = [table1Dict allKeys];
        [cell.titleLab setText:arr[indexPath.row]];
        return  cell;
    }
    else {
        WOTServiceProvidersCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTServiceProvidersCategoryCell"];
        if (cell == nil) {
            cell = [[WOTServiceProvidersCategoryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTServiceProvidersCategoryCell"];
        }
        [cell.titleLab setText:table2List[indexPath.row]];
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.table1]) {
        WOTServiceProvidersCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        table2List = table1Dict[cell.titleLab.text];
        [self.table2 reloadData];
    }
    else {
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
